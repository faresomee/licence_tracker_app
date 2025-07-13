import asyncHandler from '../middleware/asyncHandler'
import { AdminUser } from '../model/admin_user.model'
import {
  AdminResponse,
  AdminListResponse,
  ResponseCounted,
} from '../model/admin.response.model'
import { Request, Response } from 'express'
import {
  executeNonQuery,
  executeQuery,
  executeSingleQuery,
} from '../utils/orm.util'
import { RowDataPacket } from 'mysql2'
import bcrypt from 'bcrypt'
import { generateAdminJWTToken } from '../auth/admin.access'
import {
  PoliceUserResponse,
  PoliceUserListResponse,
} from '../model/police_user.response.model'
import { isPoliceUserExist } from '../auth/police_user.access'
import * as path from 'path'
import * as fs from 'fs'
import {
  saveUploadedFile,
  saveUploadedFiles,
} from '../middleware/multer.middleware'
import { HandelAttachmets, HandelViolations } from '../utils/response'
import { getFullDate, getRealTime } from '../utils/dateFormat.util'

interface AdminUserRow extends AdminUser, RowDataPacket {}

export interface CountResult extends RowDataPacket {
  total: number
}

export interface PoliceUserRow extends RowDataPacket {
  id: number
  military_id: string
  name: string
  rank_id: string
  department: string
  active: boolean
  username: string
  phone_number?: string | null
  img_profile?: string | null
  last_login?: Date | null
  created_at?: Date
  updated_at?: Date
}

const createAdmin = asyncHandler(
  async (req: Request<{}, {}, Partial<AdminUser>>, res: Response) => {
    const { name, email, password_hash, role } = req.body
    const hashedPassword = await bcrypt.hash(
      password_hash || '',
      parseInt(process.env.SALT_PASSWORD || '10'),
    )

    let img_profile = 'default.png'
    if (req.file) {
      try {
        img_profile = await saveUploadedFile(req)
      } catch (error) {
        res.status(500).json({ error: 'Failed to save profile image' })
        return
      }
    }

    const query = `INSERT INTO admin_users (name, img_profile, email, password_hash, role, status, created_at) 
                   VALUES (?, ?, ?, ?, ?, ?, ?)`
    const values = [
      name,
      img_profile,
      email,
      hashedPassword,
      role || 'admin',
      'active',
      new Date(),
    ]

    const result = await executeNonQuery(query, values)
    if (result.success) {
      res.status(201).json({
        message: 'Admin created successfully',
        affectedRows: result.affectedRows,
      })
    } else {
      if (req.file && img_profile !== 'default.png') {
        const img_path = path.join(
          __dirname,
          '..',
          'uploads',
          'images',
          'admin_users',
          img_profile,
        )
        if (fs.existsSync(img_path)) {
          fs.unlinkSync(img_path)
        }
      }
      res.status(500).json({ error: result.error })
    }
  },
)

const getAdmin = asyncHandler(
  async (req: Request, res: Response<AdminResponse>) => {
    const { id } = req.params
    const result = await executeSingleQuery<AdminUserRow>(
      'SELECT * FROM admin_users WHERE id = ?',
      [id],
    )

    if (result.success && result.data && result.data.length > 0) {
      const admin = result.data[0]
      const response: AdminResponse = {
        id: admin.id!,
        name: admin.name,
        email: admin.email,
        role: admin.role,
        status: admin.status,
        img_profile:
          req.protocol +
          '://' +
          req.get('host') +
          '/uploads/images/admin_users/' +
          admin.img_profile,
        last_login: admin.last_login,
        created_at: admin.created_at,
        updated_at: admin.updated_at,
      }
      res.json(response)
    } else {
      res.status(404).json({ error: 'Admin not found' } as any)
    }
  },
)

const getAllAdmins = asyncHandler(
  async (req: Request, res: Response<AdminListResponse>) => {
    const page = parseInt(req.query.page as string) || 1
    const limit = parseInt(req.query.limit as string) || 10
    const offset = (page - 1) * limit

    const countResult = await executeSingleQuery<CountResult>(
      'SELECT COUNT(*) as total FROM admin_users',
    )

    const result = await executeQuery<AdminUserRow>(
      `SELECT id, name, email, role, status, img_profile, last_login, created_at, updated_at 
     FROM admin_users 
     ORDER BY created_at  
     LIMIT ? OFFSET ?`,
      [limit, offset],
    )

    if (
      result.success &&
      result.data &&
      countResult.success &&
      countResult.data
    ) {
      const response: AdminListResponse = {
        data: result.data.map((admin) => ({
          id: admin.id!,
          name: admin.name,
          email: admin.email,
          role: admin.role,
          status: admin.status,
          img_profile:
            req.protocol +
            '://' +
            req.get('host') +
            '/uploads/images/admin_users/' +
            admin.img_profile,
          last_login: admin.last_login,
          created_at: admin.created_at,
          updated_at: admin.updated_at,
        })),
        pagination: {
          total: countResult.data[0].total,
          page,
          limit,
          totalPages: Math.ceil(countResult.data[0].total / limit),
        },
      }
      res.json(response)
    } else {
      res.status(500).json({ error: result.error || countResult.error } as any)
    }
  },
)

const updateAdmin = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params
  const { name, email, status, password, role } = req.body as Partial<AdminUser>

  const updates: string[] = []
  const values: any[] = []

  if (name !== undefined) {
    updates.push('name = ?')
    values.push(name)
  }
  if (role !== undefined) {
    updates.push('role = ?')
    values.push(role)
  }
  if (password !== undefined) {
    updates.push('password_hash = ?')
    const newPassword = bcrypt.hashSync(
      password,
      parseInt(process.env.SALT_PASSWORD || '10'),
    )
    values.push(newPassword)
  }
  let newImgProfile: string | undefined
  let oldImgProfile: string | null = null

  if (req.file) {
    try {
      const UserData = await executeSingleQuery<AdminUserRow>(
        'SELECT img_profile FROM admin_users WHERE id = ?',
        [id],
      )
      if (UserData.success && UserData.data && UserData.data.length > 0) {
        oldImgProfile = UserData.data[0].img_profile ?? null

        newImgProfile = await saveUploadedFile(req)
        updates.push('img_profile = ?')
        values.push(newImgProfile)

        if (oldImgProfile && oldImgProfile !== 'default.png') {
          const oldImgPath = path.join(
            __dirname,
            '..',
            'uploads',
            'images',
            'admin_users',
            oldImgProfile,
          )
          if (fs.existsSync(oldImgPath)) {
            fs.unlinkSync(oldImgPath)
          }
        }
      }
    } catch (error) {
      res.status(500).json({ error: 'Failed to save profile image' })
      return
    }
  }

  if (email !== undefined) {
    updates.push('email = ?')
    values.push(email)
  }
  if (status !== undefined) {
    updates.push('status = ?')
    values.push(status)
  }

  updates.push('updated_at = ?')
  values.push(new Date())

  if (updates.length === 1) {
    res.status(400).json({ error: 'No fields to update' })
    return
  }

  values.push(id)

  const query = `UPDATE admin_users 
                 SET ${updates.join(', ')}
                 WHERE id = ?`

  const result = await executeNonQuery(query, values)
  if (result.success) {
    res.json({
      message: 'Admin updated successfully',
      affectedRows: result.affectedRows,
    })
  } else {
    if (newImgProfile) {
      const newImgPath = path.join(
        __dirname,
        '..',
        'uploads',
        'images',
        'admin_users',
        newImgProfile,
      )
      if (fs.existsSync(newImgPath)) {
        fs.unlinkSync(newImgPath)
      }
    }
    res.status(500).json({ error: result.error })
  }
})

const deleteAdmin = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params
  const AdminData = await executeSingleQuery<AdminUserRow>(
    'SELECT * FROM admin_users WHERE id = ?',
    [id],
  )
  if (AdminData.success && AdminData.data && AdminData.data.length > 0) {
    const img_profile = AdminData.data[0].img_profile
    if (img_profile && img_profile !== 'default.png') {
      const img_path = path.join(
        __dirname,
        '..',
        'uploads',
        'images',
        'admin_users',
        img_profile,
      )
      if (fs.existsSync(img_path)) {
        fs.unlinkSync(img_path)
      }
    }
  }
  const result = await executeNonQuery('DELETE FROM admin_users WHERE id = ?', [
    id,
  ])

  if (result.success) {
    res.json({
      message: 'Admin deleted successfully',
      affectedRows: result.affectedRows,
    })
  } else {
    res.status(500).json({ error: result.error })
  }
})

const loginAdmin = asyncHandler(async (req: Request, res: Response) => {
  const { email, password } = req.body

  const result = await executeSingleQuery<AdminUserRow>(
    'SELECT * FROM admin_users WHERE email = ?',
    [email],
  )

  if (!result.success || !result.data || result.data.length === 0) {
    res.status(401).json({ error: 'Invalid credentials' })
    return
  }

  const admin = result.data[0]

  if (admin.status !== 'active') {
    res.status(403).json({ error: 'Account is not active' })
    return
  }

  const isValidPassword = await bcrypt.compare(password, admin.password_hash)

  if (!isValidPassword) {
    res.status(401).json({ error: 'Invalid credentials' })
    return
  }

  await executeNonQuery('UPDATE admin_users SET last_login = ? WHERE id = ?', [
    new Date(),
    admin.id,
  ])

  const token = generateAdminJWTToken(admin, req)

  res.json({
    message: 'Login successful',
    token,
    admin: {
      id: admin.id,
      name: admin.name,
      email: admin.email,
      role: admin.role,
      status: admin.status,
    },
  })
})

const createUser = asyncHandler(async (req: Request, res: Response) => {
  const {
    military_id,
    name,
    rank_id,
    department,
    active,
    username,
    password,
    phone_number,
    city,
  } = req.body

  const existingUser = await isPoliceUserExist(username)
  if (existingUser) {
    res.status(400).json({ error: 'Police User already exists' })
    return
  }

  let img_profile: string | null = null
  if (req.file) {
    try {
      img_profile = await saveUploadedFile(req)
    } catch (error) {
      res.status(500).json({ error: 'Failed to save profile image' })
      return
    }
  }

  const hashedPassword = await bcrypt.hash(
    password,
    parseInt(process.env.SALT_PASSWORD || '10'),
  )

  const query = `INSERT INTO police_users (military_id, name, \`rank_id\`, department, active, username, city, password_hash, phone_number, img_profile) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`
  const result = await executeNonQuery(query, [
    military_id,
    name,
    rank_id,
    department,
    active,
    username,
    city,
    hashedPassword,
    phone_number,
    img_profile,
  ])

  if (result.success) {
    res.status(200).json({ message: 'Police User created successfully' })
  } else {
    if (img_profile) {
      const img_path = path.join(
        __dirname,
        '..',
        'uploads',
        'images',
        'police_users',
        img_profile,
      )
      if (fs.existsSync(img_path)) {
        fs.unlinkSync(img_path)
      }
    }
    res.status(500).json({ error: result.error })
  }
})

const getAllUsers = asyncHandler(
  async (req: Request, res: Response<PoliceUserListResponse>) => {
    const page = parseInt(req.query.page as string) || 1
    const limit = parseInt(req.query.limit as string) || 10
    const offset = (page - 1) * limit

    const countResult = await executeSingleQuery<CountResult>(
      'SELECT COUNT(*) as total FROM police_users',
    )

    const result = await executeQuery<PoliceUserRow>(
      `SELECT pu.id, pu.military_id, pu.name, pu.rank_id, pu.department, pu.city, pu.active, pu.username, pu.phone_number, pu.img_profile, pu.last_login, pu.created_at, pu.online, pu.updated_at, (SELECT COUNT(*) FROM violations v WHERE v.police_id = pu.id) AS total_violations FROM police_users pu ORDER BY pu.created_at ASC LIMIT ? OFFSET ?;`,
      [limit, offset],
    )

    if (
      result.success &&
      result.data &&
      countResult.success &&
      countResult.data
    ) {
      const response: PoliceUserListResponse = {
        data: result.data.map((user) => ({
          id: user.id,
          badgeNum: user.military_id,
          name: user.name,
          rank_id: user.rank_id,
          department: user.department,
          city: user.city,
          active: user.active,
          username: user.username,
          phone_number: user.phone_number,
          total_violation: user.total_violations || 0,
          img_profile:
            req.protocol +
            '://' +
            req.get('host') +
            '/uploads/images/police_users/' +
            user.img_profile,
          last_login: user.last_login,
          online: user.online,
          created_at: user.created_at,
          updated_at: user.updated_at,
        })),
        pagination: {
          total: countResult.data[0].total,
          page,
          limit,
          totalPages: Math.ceil(countResult.data[0].total / limit),
        },
      }
      res.json(response)
    } else {
      res.status(500).json({ error: result.error || countResult.error } as any)
    }
  },
)

const getUser = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params
  const result = await executeSingleQuery<PoliceUserRow>(
    'SELECT p.* , v.plate_id FROM police_users p LEFT JOIN violations AS v ON p.id = v.police_id WHERE p.id = ?',
    [id],
  )
  if (result.success && result.data && result.data.length > 0) {
    const user = result.data[0]
    const violation = await HandelViolations(user)
    const response: PoliceUserResponse = {
      id: user.id,
      badgeNum: user.military_id,
      name: user.name,
      rank_id: user.rank_id,
      department: user.department,
      city: user.city,
      active: user.active,
      username: user.username,
      phone_number: user.phone_number,
      img_profile:
        req.protocol +
        '://' +
        req.get('host') +
        '/uploads/images/police_users/' +
        user.img_profile,
      last_login: user.last_login,
      online: user.online,
      created_at: user.created_at,
      updated_at: user.updated_at,
      violations: violation,
    }
    res.json(response)
  } else {
    res.status(404).json({ error: 'Police User not found' } as any)
  }
})

const deleteUser = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params
  const UserData = await executeSingleQuery<PoliceUserRow>(
    'SELECT * FROM police_users WHERE id = ?',
    [id],
  )

  if (UserData.success && UserData.data && UserData.data.length > 0) {
    const img_profile = UserData.data[0].img_profile
    if (img_profile) {
      const img_path = path.join(
        __dirname,
        '..',
        'uploads',
        'images',
        'police_users',
        img_profile,
      )
      if (fs.existsSync(img_path)) {
        fs.unlinkSync(img_path)
      }
    }
    const result = await executeNonQuery(
      'UPDATE police_users SET active = 0 WHERE id = ?',
      [id],
    )
    if (result.success) {
      res.json({ message: 'Police User deleted successfully' })
    } else {
      res.status(500).json({ error: result.error })
    }
  } else {
    res.status(404).json({ error: 'Police User not found' })
  }
})

const updateUser = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params
  const {
    military_id,
    name,
    rank_id,
    department,
    active,
    username,
    phone_number,
    city,
    password,
  } = req.body

  const updates: string[] = []
  const values: any[] = []

  if (military_id !== undefined) {
    updates.push('military_id = ?')
    values.push(military_id)
  }
  if (password !== undefined) {
    updates.push('password_hash = ?')
    const newPassword = bcrypt.hashSync(
      password,
      parseInt(process.env.SALT_PASSWORD || '10'),
    )
    values.push(newPassword)
  }
  if (name !== undefined) {
    updates.push('name = ?')
    values.push(name)
  }

  if (rank_id !== undefined) {
    updates.push('rank_id = ?')
    values.push(rank_id)
  }

  if (department !== undefined) {
    updates.push('department = ?')
    values.push(department)
  }

  if (active !== undefined) {
    updates.push('active = ?')
    values.push(active)
  }

  if (username !== undefined) {
    updates.push('username = ?')
    values.push(username)
  }

  if (city !== undefined) {
    updates.push('city = ?')
    values.push(city)
  }

  if (phone_number !== undefined) {
    updates.push('phone_number = ?')
    values.push(phone_number)
  }

  let newImgProfile: string | undefined
  let oldImgProfile: string | null = null

  if (req.file) {
    try {
      const UserData = await executeSingleQuery<PoliceUserRow>(
        'SELECT img_profile FROM police_users WHERE id = ?',
        [id],
      )
      if (UserData.success && UserData.data && UserData.data.length > 0) {
        oldImgProfile = UserData.data[0].img_profile ?? null

        newImgProfile = await saveUploadedFile(req)
        updates.push('img_profile = ?')
        values.push(newImgProfile)

        if (oldImgProfile && oldImgProfile !== 'default.png') {
          const oldImgPath = path.join(
            __dirname,
            '..',
            'uploads',
            'images',
            'police_users',
            oldImgProfile,
          )
          if (fs.existsSync(oldImgPath)) {
            fs.unlinkSync(oldImgPath)
          }
        }
      }
    } catch (error) {
      res.status(500).json({ error: 'Failed to save profile image' })
      return
    }
  }

  updates.push('updated_at = ?')
  values.push(new Date())

  if (updates.length === 1) {
    res.status(400).json({ error: 'No fields to update' })
    return
  }

  values.push(id)

  const query = `UPDATE police_users 
                 SET ${updates.join(', ')}
                 WHERE id = ?`

  const result = await executeNonQuery(query, values)
  if (result.success) {
    res.json({
      message: 'Police User updated successfully',
      affectedRows: result.affectedRows,
    })
  } else {
    if (newImgProfile) {
      const newImgPath = path.join(
        __dirname,
        '..',
        'uploads',
        'images',
        'police_users',
        newImgProfile,
      )
      if (fs.existsSync(newImgPath)) {
        fs.unlinkSync(newImgPath)
      }
    }
    res.status(500).json({ error: result.error })
  }
})
const getAllViolations = asyncHandler(async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string) || 1
  const limit = parseInt(req.query.limit as string) || 10
  const offset = (page - 1) * limit

  const countResult = await executeSingleQuery<CountResult>(
    'SELECT COUNT(*) as total FROM violations',
  )

  const data = await executeQuery(
    'SELECT v.id , v.plate_id , v.location , vt.name , v.status , v.attachments, v.description FROM violations v JOIN violation_type vt ON vt.ID = v.type LIMIT  ? OFFSET  ?;',
    [limit, offset],
  )
  let newData

  if (data && data.data) {
    newData = data.data?.map((violation) => {
      return {
        ...violation,
        attachments: violation.attachments
          ? HandelAttachmets(
              violation.attachments,
              req.protocol,
              req.get('host'),
            )
          : undefined,
      }
    })
  }
  if (countResult && countResult.data)
    res.json({
      sucess: true,
      data: newData,
      pagination: {
        total: countResult.data[0].total,
        totalPages: Math.ceil(countResult.data[0].total / limit),
        page: page,
        limit: limit,
      },
    })
})

const getViolationsType = asyncHandler(async (req: Request, res: Response) => {
  const data = await executeQuery('SELECT * FROM violation_type')
  res.status(200).json(data.data)
})

const getSpesificViolation = asyncHandler(
  async (req: Request, res: Response) => {
    const id = req.params.id
    const result = await executeQuery(
      `SELECT 
      p.national_id AS vehicle_owner_id,
      v.plate AS vehicle_plate, 
      p.full_name AS vehicle_owner_name, 
      p.address AS owner_location, 
      v.brand AS vehicle_brand, 
      vio.id AS violation_id, 
      vt.name AS violation_type_name, 
      vio.created_at AS violation_date, 
      vio.location AS violation_location, 
      pu.name AS officer_name, 
      pu.id AS officer_id, 
      vio.status AS violation_status, 
      vio.attachments as attachments,
      vio.description AS violation_description 
    FROM violations vio 
    JOIN vehicle v ON vio.plate_id = v.plate 
    JOIN vehicle_license vl ON v.plate = vl.vehicle_plate 
    JOIN driver_license dl ON vl.driving_license_id = dl.number 
    JOIN person p ON dl.driver_id = p.national_id 
    JOIN violation_type vt ON vio.type = vt.ID 
    JOIN police_users pu ON vio.police_id = pu.id 
    WHERE vio.id = ?;`,
      [id],
    )

    const data = result.data?.map((row: any) => ({
      ...row,
      violation_date: getFullDate(row.violation_date),
      attachments: row.attachments
        ? HandelAttachmets(row.attachments, req.protocol, req.get('host'))
        : undefined,
    }))

    res.json(data ? data[0] : data)
  },
)

const createViolationForAdmin = asyncHandler(
  async (req: Request, res: Response) => {
    let attachmentPaths: string[] = []

    if (req.files && Array.isArray(req.files) && req.files.length > 0) {
      const savedFiles = await saveUploadedFiles(req)
      attachmentPaths = savedFiles.map((filename) => `${filename}`)
      const query = `
          INSERT INTO violations 
          (police_id, plate_id, location, type, description, attachments , status )
          VALUES (?, ?, ?, ?, ?, ?,?)
        `
      const values = [
        req.body.police_id,
        req.body.plate_id,
        req.body.location,
        req.body.type,
        req.body.description,
        JSON.stringify(attachmentPaths),
        'under_review',
      ]
      await executeQuery(query, values)
    } else {
      const query = `
              INSERT INTO violations 
              (police_id, plate_id, location, type, description , status )
              VALUES (?, ?, ?, ?, ?,?)
          `
      const values = [
        req.body.police_id,
        req.body.plate_id,
        req.body.location,
        req.body.type,
        req.body.description,
        'under_review',
      ]
      await executeQuery(query, values)
    }

    res.status(201).json({ success: true, message: 'Ticket created' })
  },
)

const deleteViolationByAdmin = asyncHandler(
  async (req: Request, res: Response) => {
    const { id } = req.params

    if (!id) {
      res.status(400).json({ message: 'Violation ID is required' })
      return
    }

    const query = 'DELETE FROM violations WHERE id = ?'
    const result = await executeNonQuery(query, [id])

    if (result.affectedRows === 0) {
      res.status(404).json({ message: 'Violation not found' })
      return
    }

    res.status(200).json({ message: 'Violation deleted successfully' })
  },
)

const updateViolationByAdmin = asyncHandler(
  async (req: Request, res: Response) => {
    const id = Number(req.params.id)
    const { status } = req.body

    if (!id || !status) {
      res.status(400).json({ message: 'Violation ID and status are required' })
      return
    }

    if (isNaN(id)) {
      res.status(400).json({ message: 'Violation ID must be a valid number' })
      return
    }
    const validStatuses = ['paied', 'unpaied', 'under_review']
    if (!validStatuses.includes(status)) {
      res.status(400).json({ message: 'Invalid status value' })
      return
    }

    const query = 'UPDATE violations SET status = ? WHERE id = ?'
    const result = await executeNonQuery(query, [status, id])

    if (result.affectedRows === 0) {
      res
        .status(404)
        .json({ message: 'Violation not found or already has this status' })
      return
    }

    res.status(200).json({ message: 'Violation status updated successfully' })
  },
)
const getAllVheciles = asyncHandler(async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string) || 1
  const limit = parseInt(req.query.limit as string) || 10
  const offset = (page - 1) * limit

  const countQuery = `SELECT COUNT(*) AS total FROM vehicle`
  const countResult = await executeQuery<ResponseCounted>(countQuery, [])
  let total = 0
  if (countResult && countResult.data) {
    total = countResult.data[0].total
  }

  const dataQuery = `
    SELECT * FROM vehicle
    LIMIT ? OFFSET ?
  `
  const data = await executeQuery(dataQuery, [limit, offset])

  res.json({
    data: data.data,
    pagination: {
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    },
  })
})
const getAllUsersAccounts = asyncHandler(
  async (req: Request, res: Response) => {
    try {
      const page = parseInt(req.query.page as string, 10) || 1
      const limit = parseInt(req.query.limit as string, 10) || 10
      const offset = (page - 1) * limit

      const usersResult = await executeQuery(
        'SELECT * FROM user_accounts LIMIT ? OFFSET ?',
        [limit, offset],
      )
      const users = usersResult?.data || []

      const sanitizedUsers = users.map((user: any) => {
        const { password, ...safeUser } = user
        return safeUser
      })

      const countResult = await executeQuery(
        'SELECT COUNT(*) AS total FROM user_accounts',
      )
      const total = countResult?.data?.[0]?.total || 0
      const totalPages = Math.ceil(total / limit)

      res.status(200).json({
        success: true,
        message: 'Users fetched successfully.',
        data: sanitizedUsers,
        pagination: { page, limit, total, totalPages },
      })
    } catch (error) {
      console.error('Error fetching users:', error)
      res.status(500).json({
        success: false,
        message: 'An error occurred while fetching user accounts.',
      })
    }
  },
)

const getAllUsersReports = asyncHandler(async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string, 10) || 1
  const limit = parseInt(req.query.limit as string, 10) || 10
  const offset = (page - 1) * limit

  const usersResult = await executeQuery(
    'SELECT * FROM user_report LIMIT ? OFFSET ?',
    [limit, offset],
  )

  const countResult = await executeQuery(
    'SELECT COUNT(*) AS total FROM user_report',
  )
  const total = countResult?.data?.[0]?.total || 0
  const totalPages = Math.ceil(total / limit)

  const data = usersResult.data?.map((row: any) => ({
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

  res.status(200).json({
    success: true,
    message: 'reports fetched successfully.',
    data: data,
    pagination: { page, limit, total, totalPages },
  })
})

const getAllUsersObjections = asyncHandler(
  async (req: Request, res: Response) => {
    const page = parseInt(req.query.page as string, 10) || 1
    const limit = parseInt(req.query.limit as string, 10) || 10
    const offset = (page - 1) * limit

    const usersResult = await executeQuery(
      'SELECT * FROM user_objections LIMIT ? OFFSET ?',
      [limit, offset],
    )

    const countResult = await executeQuery(
      'SELECT COUNT(*) AS total FROM user_objections',
    )
    const total = countResult?.data?.[0]?.total || 0
    const totalPages = Math.ceil(total / limit)

    res.status(200).json({
      success: true,
      message: 'objections fetched successfully.',
      data: usersResult.data,
      pagination: { page, limit, total, totalPages },
    })
  },
)

const changeUserReportStatus = asyncHandler(
  async (req: Request, res: Response) => {
    const id = req.params.id
    const newStatus = req.body.status
    const isReportFound = await executeSingleQuery(
      'SELECT COUNT(*) as total FROM user_report WHERE id = ?',
      [id],
    )
    if (isReportFound && isReportFound.data) {
      console.log(isReportFound.data)
      if (isReportFound.data[0].total === 0) {
        res.status(404).json({
          status: false,
          message: `Report Not Found With ID ${id}`,
        })
        return
      }
    }
    const data = await executeQuery(
      'UPDATE user_report SET status = ? WHERE id = ?',
      [newStatus, id],
    )
    if (data.success) {
      res.status(200).json({
        success: true,
        message: 'Status updated successfully.',
        data: data.data,
      })
    } else {
      res.status(200).json({
        success: false,
        message:
          'No changes were made. The status might already be set to the specified value.',
        data: data.data,
      })
    }
  },
)
const changeUserObjectionStatus = asyncHandler(
  async (req: Request, res: Response) => {
    const id = req.params.id
    const newStatus = req.body.status
    const isObjectionExisits = await executeSingleQuery(
      'SELECT COUNT(*) as total FROM user_objections WHERE id = ?',
      [id],
    )
    if (isObjectionExisits && isObjectionExisits.data) {
      console.log(isObjectionExisits.data)
      if (isObjectionExisits.data[0].total === 0) {
        res.status(404).json({
          status: false,
          message: `Objection Not Found With ID ${id}`,
        })
        return
      }
    }
    const data = await executeQuery(
      'UPDATE user_objections SET status = ? WHERE id = ?',
      [newStatus, id],
    )
    if (data.success) {
      res.status(200).json({
        success: true,
        message: 'Status updated successfully.',
        data: data.data,
      })
    } else {
      res.status(200).json({
        success: false,
        message:
          'No changes were made. The status might already be set to the specified value.',
        data: data.data,
      })
    }
  },
)

export {
  createAdmin,
  getAdmin,
  getAllAdmins,
  updateAdmin,
  deleteAdmin,
  loginAdmin,
  createUser,
  getAllUsers,
  getUser,
  updateUser,
  deleteUser,
  getAllViolations,
  getViolationsType,
  getSpesificViolation,
  createViolationForAdmin,
  deleteViolationByAdmin,
  updateViolationByAdmin,
  getAllVheciles,
  getAllUsersAccounts,
  getAllUsersReports,
  getAllUsersObjections,
  changeUserReportStatus,
  changeUserObjectionStatus,
}
