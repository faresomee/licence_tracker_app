import asyncHandler from '../middleware/asyncHandler'
import { Request, Response } from 'express'
import {
  executeSingleQuery,
  executeNonQuery,
  executeQuery,
} from '../utils/orm.util'
import bcrypt from 'bcrypt'
import { generateUserJWTToken } from '../auth/user.access'
import { IUser } from '../model/default.user'
import { saveUploadedFiles } from '../middleware/multer.middleware'
import { HandelAttachmets } from '../utils/response'

export const register = asyncHandler(async (req: Request, res: Response) => {
  const { national_id, email, password } = req.body
  const fetchIsUserExisits = await executeQuery(
    'SELECT * FROM user_accounts WHERE national_id = ? OR email = ?',
    [national_id, email],
  )
  const fetchNationalIdData = await executeSingleQuery(
    'SELECT * FROM person where national_id = ?',
    [national_id],
  )
  const isUserExists = fetchIsUserExisits.data?.length
  const isNationalIdExsits = fetchNationalIdData.data?.length
  if (isUserExists === 1) {
    res.status(409).json({
      sucess: false,
      message:
        'A user with the provided credentials already exists. Please use a different national ID or email, or proceed to login if you already have an account.',
    })
    return
  }
  if (!isNationalIdExsits) {
    res.status(404).json({
      sucess: false,
      message:
        'No user found with the provided national ID. Please verify the number and try again.',
    })
    return
  }
  const hash_password = await bcrypt.hash(
    password,
    parseInt(process.env.SALT_PASSWORD || '10'),
  )
  const result = await executeNonQuery(
    'INSERT INTO user_accounts (national_id , email,password) VALUES (?,?,?)',
    [national_id, email, hash_password],
  )
  if (result.success) {
    res.status(201).json({
      sucess: true,
      message: 'User account has been successfully created.',
    })
  }
})

export const login = asyncHandler(async (req: Request, res: Response) => {
  const { email, password } = req.body
  const userData = await executeSingleQuery<IUser>(
    'SELECT * FROM user_accounts WHERE email = ?',
    [email],
  )
  if (userData.data?.length === 0) {
    res.status(401).json({
      sucess: false,
      message:
        'Invalid email or password. Please check your credentials and try again.',
    })
    return
  }
  const user_password = userData.data
    ? userData.data[0].password
    : new Error('Somthing Happend')
  const correct_password = await bcrypt.compare(password, user_password)

  if (!correct_password) {
    res.status(401).json({
      sucess: false,
      message:
        'Invalid email or password. Please check your credentials and try again.',
    })
    return
  }
  if (userData && userData.data) {
    const user: IUser[] = userData.data
    const token = generateUserJWTToken(user[0])
    res.status(200).json({
      sucess: true,
      token,
    })
  }
})
export const searchVehcile = asyncHandler(
  async (req: Request, res: Response) => {
    const { id } = req.params
    if (!id) {
      res.status(400).json({
        error:
          "Missing required parameter: 'id'. Please include a valid ID in the request URL.",
      })
      return
    }
    // const data = await executeSingleQuery<VehicleResponse>(
    //   `SELECT
    //      v.*,
    //      EXISTS (
    //        SELECT 1
    //        FROM wanted_vehicle w
    //        WHERE w.plate = v.plate
    //      ) AS is_wanted,
    //      (
    //        SELECT JSON_ARRAYAGG(
    //          JSON_OBJECT(
    //            'id', vio.id,
    //            'location', vio.location,
    //            'type', vio.type,
    //            'status', vio.status,
    //            'action', vio.action,
    //            'description', vio.description,
    //            'created_at', vio.created_at
    //          )
    //        )
    //        FROM violations vio
    //        WHERE vio.plate_id = v.plate
    //      ) AS violations
    //    FROM vehicle v
    //    WHERE v.plate = ?`,
    //   [id]
    // );

    const result = await executeSingleQuery(
      `
SELECT 
  v.plate,
  CASE 
    WHEN wv.plate IS NOT NULL THEN TRUE 
    ELSE FALSE 
  END AS is_wanted,
  IF(COUNT(vio.id) > 0,
    JSON_ARRAYAGG(
      JSON_OBJECT(
        'violation_id', vio.id,
        'location', IFNULL(vio.location, ''),
        'description', IFNULL(vio.description, ''),
        'status', IFNULL(vio.status, ''),
        'type_name', IFNULL(vt.name, '')
      )
    ),
    JSON_ARRAY()
  ) AS violations
FROM vehicle v
LEFT JOIN wanted_vehicle wv ON v.plate = wv.plate
LEFT JOIN violations vio ON v.plate = vio.plate_id
LEFT JOIN violation_type vt ON vio.type = vt.ID
WHERE v.plate = ?
GROUP BY v.plate, is_wanted;
`,
      [id],
    )

    res.json(result)
  },
)

export const createReport = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user_data

    let attachmentPaths: string[] = []

    if (req.files && Array.isArray(req.files) && req.files.length > 0) {
      const savedFiles = await saveUploadedFiles(req)
      attachmentPaths = savedFiles.map((filename) => `${filename}`)
      const query = `
            INSERT INTO user_report 
            (name, phone, national_id, address, date, vehcile_types, description , attachment )
            VALUES (?, ?, ?, ?, ?, ?,?,?)
          `
      const values = [
        req.body.name,
        req.body.phone,
        user.id,
        req.body.address,
        req.body.date,
        req.body.vehcile_types,
        req.body.description,
        JSON.stringify(attachmentPaths),
      ]
      await executeQuery(query, values)
    } else {
      res.status(401).json({
        message: 'images not found',
      })
      return
    }

    res.status(201).json({ success: true, message: 'Report created' })
  },
)

export const getReport = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params
  const user = (req as any).user_data
  if (!id) {
    res.status(400).json({ message: 'Report ID is required in URL params.' })
    return
  }
  const result = await executeSingleQuery(
    'SELECT * FROM user_report WHERE id = ? AND national_id = ?',
    [id, user.id],
  )

  const data = result.data?.map((row: any) => ({
    ...row,
    attachment: row.attachment
      ? HandelAttachmets(
          row.attachment,
          req.protocol,
          req.get('host'),
          'user_report',
        )
      : undefined,
  }))

  if (result && result.data) {
    res.status(200).json(data)
  } else {
    res.status(200).json({})
  }
})

export const generateObjection = asyncHandler(
  async (req: Request, res: Response) => {
    const { report_id, description } = req.body
    const user = (req as any).user_data
    const data = await executeSingleQuery(
      "SELECT COUNT(*) as total FROM user_objections WHERE id = ? AND national_id = ? AND status = 'pending'  ",
      [report_id, user.id],
    )
    const userdata = await executeSingleQuery(
      'SELECT COUNT(*) as total FROM user_report WHERE id = ? AND status = "rejected" ',
      [report_id],
    )
    if (userdata && userdata.data) {
      if (userdata.data[0].total === 0) {
        res.status(404).json({
          message:
            'No objection found for the provided ID, or your report has not been reviewed yet.',
        })
        return
      }
    }
    if (data && data.data) {
      if (data.data[0].total > 0) {
        res.status(401).json({
          message:
            'You have exceeded the maximum number of allowed objections.',
        })
        return
      }
    }
    const result = await executeNonQuery(
      'INSERT INTO user_objections (report_id ,national_id,description, status) VALUES (?,?,?,?)',
      [report_id, user.id, description, 'pending'],
    )
    res.json({ message: 'objection created' })
  },
)
