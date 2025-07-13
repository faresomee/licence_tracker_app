import {
  executeSingleQuery,
  executeNonQuery,
  executeQuery,
} from '../utils/orm.util'
import { Request, Response } from 'express'
import {
  generatePoliceUserJWTToken,
  validatePoliceToken,
} from '../auth/police_user.access'
import { PoliceUser } from '../model/police_user.model'
import asyncHandler from '../middleware/asyncHandler'
import bcrypt from 'bcrypt'
import { getOTP, sendOTP } from '../utils/otp'
import { formatDateV2 } from '../utils/dateFormat.util'
import {
  generateActivitesCard,
  generateDescriptionForNotification,
  generateUrgentCard,
} from '../utils/response'

export const loginPoliceUser = asyncHandler(
  async (req: Request, res: Response) => {
    try {
      const { username, password, phone_number, sms_otp } = req.body
      const result = await executeSingleQuery<PoliceUser>(
        'SELECT * FROM police_users WHERE username = ?',
        [username],
      )
      if (!result.success || !result.data || result.data.length === 0) {
        res.status(401).json({ message: 'Invalid username or password' })
        return
      }
      const policeUser = result.data[0]
      const isPasswordValid = await bcrypt.compare(
        password,
        policeUser.password_hash,
      )
      if (!isPasswordValid) {
        res.status(401).json({ message: 'Invalid username or password' })
        return
      }
      if (policeUser.phone_number !== phone_number) {
        res.status(401).json({ message: 'Invalid phone number' })
        return
      }
      const otp = await getOTP(policeUser.id, 'login')
      if (otp === null) {
        res.status(401).json({
          message: 'يجب عليك إنشاء رمز تحقق (OTP) أولاً قبل تسجيل الدخول.',
        })
        return
      }
      if (sms_otp !== otp) {
        res
          .status(401)
          .json({ message: 'رمز التحقق غير صحيح. يرجى المحاولة مرة أخرى.' })
        return
      }
      const token = generatePoliceUserJWTToken(policeUser, req)
      await executeNonQuery(
        'UPDATE police_users SET last_login = ? WHERE id = ?',
        [new Date(), policeUser.id],
      )
      const query = 'UPDATE police_users SET online = 1 WHERE id = ?'
      await executeNonQuery(query, [policeUser.id])
      await executeNonQuery('DELETE FROM sms_otp WHERE police_id = ?', [
        policeUser.id,
      ])
      // sendOTP(policeUser.phone_number, policeUser.id)
      res.status(200).json({
        message: 'Police user logged in successfully',
        token,
        user: policeUser,
      })
    } catch (error) {
      console.error('Login error:', error)
      res.status(500).json({ message: 'Internal server error' })
    }
  },
)

export const generateOTPRequestForPassword = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    await sendOTP(user.phone_number, user.id, 'password')
    const otp = await getOTP(user.id, 'password')
    res.status(200).json({
      message: 'OTP sent successfully for password reset',
      sms_otp: otp,
    })
  },
)

export const changePasswordForPoliceUser = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    const opt = req.body.sms_otp
    const getOtpFromDB = await getOTP(user.id, 'password')
    console.log('getOtpFromDB', getOtpFromDB)
    if (getOtpFromDB === null) {
      res.status(401).json({
        message: 'يجب عليك إنشاء رمز تحقق (OTP) أولاً قبل تغيير كلمة المرور.',
      })
      return
    }
    if (opt !== getOtpFromDB) {
      res.status(401).json({
        message: 'رمز التحقق غير صحيح. يرجى المحاولة مرة أخرى.',
      })
      return
    }
    const { password } = req.body
    const hashedPassword = await bcrypt.hash(
      password,
      parseInt(process.env.SALT_PASSWORD || '10'),
    )
    const query = 'UPDATE police_users SET password_hash = ? WHERE id = ?'
    const result = await executeNonQuery(query, [
      hashedPassword,
      (req as any).user.id,
    ])
    await executeNonQuery(
      'DELETE FROM sms_otp WHERE police_id = ? AND type = ?',
      [(req as any).user.id, 'password'],
    )
    await executeNonQuery(
      'INSERT INTO notification_police (type,police_id) VALUES (?,?)',
      ['password change', user.id],
    )
    res.status(200).json({
      message: 'تم تغيير كلمة المرور بنجاح',
      success: true,
    })
  },
)
export const generateOTPRequest = asyncHandler(
  async (req: Request, res: Response) => {
    try {
      const { phone_number } = req.body
      const result = await executeSingleQuery<PoliceUser>(
        'SELECT * FROM police_users WHERE phone_number = ?',
        [phone_number],
      )
      if (!result.success || !result.data || result.data.length === 0) {
        res.status(401).json({ message: 'Invalid phone number' })
        return
      }
      const policeUser = result.data[0]
      await sendOTP(policeUser.phone_number, policeUser.id, 'login')
      const otp = await getOTP(policeUser.id, 'login')
      res.status(200).json({
        message: 'OTP sent successfully',
        sms_otp: otp,
      })
    } catch (error) {
      console.error('Login error:', error)
      res.status(500).json({ message: 'Internal server error' })
    }
  },
)
export const logoutPoliceUser = asyncHandler(
  async (req: Request, res: Response) => {
    try {
      const user = (req as any).user
      const query = 'UPDATE police_users SET online = 0 WHERE id = ?'
      await executeNonQuery(query, [user.id])
      res.status(200).json({
        message: `Police User logged out successfully`,
      })
    } catch (error) {
      console.error('Logout error:', error)
      res.status(500).json({ message: 'Internal server error' })
    }
  },
)

export const getMyDetails = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    const result = await executeSingleQuery<PoliceUser>(
      'SELECT * FROM police_users WHERE id = ?',
      [user.id],
    )
    if (result.success && result.data && result.data.length > 0) {
      const userData = result.data[0]
      const { password_hash, ...safeUserData } = userData
      res.status(200).json({
        success: true,
        data: safeUserData,
      })
    } else {
      res.status(404).json({
        success: false,
        message: 'User not found',
      })
    }
  },
)

export const getMyNotification = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    const query =
      'SELECT id , type , created_at FROM notification_police WHERE police_id = ? ORDER BY created_at ASC'
    const result = await executeQuery(query, [user.id])
    const userData = result.data?.map((notification) => {
      return {
        ...notification,
        created_at: formatDateV2(notification.created_at),
        description: generateDescriptionForNotification(notification.type),
      }
    })
    res.status(200).json({
      sucess: true,
      data: userData,
    })
  },
)

export const getMyStatistics = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    const totalWantedVehcileQuery =
      "SELECT COUNT(*) AS 'total_wanted_veh' FROM wanted_vehicle WHERE DATE(created_at) = CURRENT_DATE;"
    const totalReportsQuery =
      "SELECT COUNT(*) AS 'total_reports' FROM police_reports WHERE police_id = ? AND DATE(created_at) = CURRENT_DATE;"
    const totalTicketsQuery =
      "SELECT COUNT(*) AS 'total_ticket' FROM violations WHERE police_id = ? AND DATE(create_at) = CURRENT_DATE;"
    const totalInspectedQuery =
      "SELECT COUNT(*) AS 'total_inspected' FROM inspected_vehicles WHERE police_id = ? AND DATE(create_at) = CURRENT_DATE;"

    const totalVehcile = await executeQuery(totalWantedVehcileQuery, [])
    const totalReports = await executeQuery(totalReportsQuery, [user.id])
    const totalTickets = await executeQuery(totalTicketsQuery, [user.id])
    const totalInspected = await executeQuery(totalInspectedQuery, [user.id])

    res.status(200).json({
      totalVehcile: totalVehcile.data?.[0]?.total_wanted_veh ?? 0,
      totalReports: totalReports.data?.[0]?.total_reports ?? 0,
      totalTickets: totalTickets.data?.[0]?.total_ticket ?? 0,
      totalInspected: totalInspected.data?.[0]?.total_inspected ?? 0,
    })
  },
)

export const getUrgentTasks = asyncHandler(
  async (req: Request, res: Response) => {
    const wantedvehicleQuery =
      'SELECT vh.*,wh.description, wh.created_at FROM wanted_vehicle AS wh JOIN vehicle AS vh ON wh.plate = vh.plate ORDER BY wh.created_at ASC LIMIT 1;'
    const wantedPersonsQuery =
      'SELECT p.national_id , p.criminal_status , p.changed FROM person p WHERE p.criminal_status = 1 ORDER BY changed ASC LIMIT 1;'
    const wntedVehicle = await executeQuery(wantedvehicleQuery, [])
    const wantedPerson = await executeQuery(wantedPersonsQuery, [])
    const data = generateUrgentCard(wntedVehicle.data, wantedPerson.data)
    res.status(200).json({ data })
  },
)

export const getActivites = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    const getTicketQuery = `SELECT
    vt.name AS "violation_type",
    v.description,
    va.name as "violation_action",
    v.created_at,
    veh.name AS "vehicle_name",
    veh.brand,
    veh.type,
    veh.plate
FROM
    violations v
JOIN violation_type vt ON
    vt.ID = v.type
INNER JOIN violation_action va ON
    va.id = v.action
RIGHT OUTER JOIN vehicle veh ON
    veh.plate = v.plate_id
    WHERE police_id = ? LIMIT 1;`
    const cehckQuery = `SELECT veh.plate , veh.brand , veh.type , veh.name , iv.create_at FROM inspected_vehicles iv JOIN vehicle veh ON veh.plate = iv.plate WHERE police_id = ? AND DATE(create_at) = CURRENT_DATE LIMIT 1;`
    const ticketResult = await executeQuery(getTicketQuery, [user.id])
    const cehckResult = await executeQuery(cehckQuery, [user.id])
    let wantedVehicle
    if (
      cehckResult.data &&
      cehckResult.data.length > 0 &&
      cehckResult.data[0].plate
    ) {
      wantedVehicle = await executeQuery(
        'SELECT wh.plate,wh.description,wh.created_at FROM inspected_vehicles iv JOIN wanted_vehicle wh ON wh.plate = iv.plate WHERE wh.plate = ? ORDER BY created_at ASC LIMIT 1;',
        [cehckResult.data[0].plate],
      )
    }
    const data = generateActivitesCard(
      ticketResult.data,
      cehckResult.data,
      wantedVehicle ? wantedVehicle.data : undefined,
    )
    res.status(200).json({
      data,
    })
  },
)
