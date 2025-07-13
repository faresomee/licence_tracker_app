import {
  executeNonQuery,
  executeQuery,
  executeSingleQuery,
} from '../utils/orm.util'
import { Request, Response } from 'express'
import asyncHandler from '../middleware/asyncHandler'
import { PoliceUser } from '../model/police_user.model'
import { formatDate } from '../utils/dateFormat.util'
import crypto from 'crypto'

export const getMyReports = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    const result = await executeQuery<PoliceUser>(
      'SELECT r.id , r.title , r.description , r.status , r.date, rt.name AS report_type_name FROM reports AS r RIGHT JOIN police_reports AS pr ON pr.report_id = r.id LEFT JOIN report_type as rt ON r.type = rt.id WHERE pr.police_id = ?',
      [user.id],
    )
    if (result.success && result.data) {
      const userData = result.data.map((report) => {
        return {
          ...report,
          date: formatDate(report.date),
        }
      })
      res.status(200).json({
        success: true,
        data: userData || [],
      })
    } else {
      res.status(404).json({
        success: false,
        message: 'No reports found for the user',
      })
    }
  },
)

export const getSpesificReport = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user
    const reportId = req.params.id

    const result = await executeQuery<PoliceUser>(
      'SELECT rp.id , rp.title , rp.description , rp.status , rp.date, tp.name AS report_type_name FROM reports AS rp RIGHT JOIN police_reports AS pr ON rp.id = pr.report_id LEFT JOIN report_type AS tp ON rp.type = tp.id WHERE  pr.police_id = ? AND rp.id LIKE ? ;',
      [user.id, `%${reportId}%`],
    )

    if (result.success && result.data) {
      const userData = result.data.map((report) => {
        return {
          ...report,
          date: formatDate(report.date),
        }
      })
      res.status(200).json({
        success: true,
        data: userData || [],
      })
    } else {
      res.status(404).json({
        success: false,
        message: 'No reports found for the user',
      })
    }
  },
)

export const CreateReport = asyncHandler(
  async (req: Request, res: Response) => {
    const { title, type, description } = req.body
    const id = crypto.randomUUID().replace(/-/g, '')
    const user = (req as any).user
    const reportQuery = await executeNonQuery(
      'INSERT INTO reports (id , title , description ,type) VALUES(?, ?, ? , ?)',
      [id, title, description, type],
    )
    const linkQuery = await executeNonQuery(
      'INSERT INTO police_reports (police_id , report_id ) VALUES(?, ?)',
      [user.id, id],
    )

    if (reportQuery.success && linkQuery.success) {
      res.status(201).json({
        success: true,
        message: `Report created successfully With id ${id}`,
      })
    } else {
      res.status(500).json({
        success: false,
        message: 'Failed to create report',
      })
    }
  },
)

export const getAllReportTypes = asyncHandler(
  async (req: Request, res: Response) => {
    const result = await executeQuery('SELECT * FROM report_type', [])
    if (result.success && result.data) {
      res.status(200).json({
        success: true,
        data: result.data || [],
      })
    } else {
      res.status(404).json({
        success: false,
        message: 'No report types found',
      })
    }
  },
)
exports = {
  getMyReports,
  CreateReport,
  getSpesificReport,
  getAllReportTypes,
}
