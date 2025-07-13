import {
  executeNonQuery,
  executeQuery,
  executeSingleQuery,
} from '../utils/orm.util'
import asyncHandler from '../middleware/asyncHandler'
import { Request, Response } from 'express'
import { formatDate, getFullDate } from '../utils/dateFormat.util'
import { reportScore } from '../utils/reportScore'
import { CountResult } from './admin.controller'

export const getAllReports = asyncHandler(
  async (req: Request, res: Response) => {
    const page = parseInt(req.query.page as string) || 1
    const limit = parseInt(req.query.limit as string) || 10
    const offset = (page - 1) * limit

    const result = await executeQuery(
      'SELECT rp.id AS report_id , pu.id AS police_id , pu.name AS officer_name, rp.title, rp.description, rp.status, rp.date, rt.name AS report_name, rt.point AS SCORE FROM reports AS rp INNER JOIN police_reports AS pr ON rp.id = pr.report_id INNER JOIN report_type AS rt ON rp.type = rt.id INNER JOIN police_users AS pu ON pu.id = pr.police_id LIMIT ? OFFSET ?;',
      [limit, offset],
    )

    const countResult = await executeSingleQuery<CountResult>(
      'SELECT COUNT(*) as total FROM reports',
    )
    if (result.success && result.data) {
      const userData = result.data.map((report) => {
        return {
          ...report,
          date: getFullDate(report.date),
          SCORE: reportScore(report.SCORE),
        }
      })
      if (countResult && countResult.data)
        res.status(200).json({
          success: true,
          data: userData || [],
          pagination: {
            total: countResult.data[0].total,
            page,
            limit,
            totalPages: Math.ceil(countResult.data[0].total / limit),
          },
        })
    }
  },
)
// return ALL police Officer Viloations
export const getSpesificReport = asyncHandler(
  async (req: Request, res: Response) => {
    const reportId = req.params.id
    const query = `
  SELECT
      rp.id,
      rt.name,
      rp.title,
      rp.description,
      rp.status,
      rp.date,
      pc.id AS police_id,
      pc.name AS police_name,
      SUM(rt.point) AS SCORE
      
      
  FROM
      reports AS rp
  INNER JOIN police_reports AS pr ON rp.id = pr.report_id
  INNER JOIN report_type AS rt ON rp.type = rt.id
  INNER JOIN police_users AS pc ON pc.id = pr.police_id
  WHERE
      rp.id LIKE ?
      GROUP BY
    rp.id,
    rt.name,
    rp.title,
    rp.description,
    rp.status,
    rp.date,
    pc.id;
;
`

    const result = await executeSingleQuery(query, [`%${reportId}%`])

    if (result.success && result.data) {
      const userData = result.data.map((report) => {
        return {
          ...report,
          SCORE: reportScore(report.SCORE),
          date: getFullDate(report.date),
        }
      })
      res.status(200).json({
        success: true,
        data: userData || [],
      })
    } else {
      res.status(404).json({
        success: false,
        message:
          'Sorry, no report found for the provided ID. Please verify the ID and try again.',
      })
    }
  },
)

export const deleteReport = asyncHandler(
  async (req: Request, res: Response) => {
    const reportId = req.params.id
    const result = await executeNonQuery(
      'DELETE FROM police_reports WHERE report_id = ?',
      [reportId],
    )
    await executeNonQuery('DELETE FROM reports WHERE id = ?', [reportId])
    if (result.success && (result.affectedRows ?? 0) > 0) {
      res.status(200).json({
        success: true,
        message: '✅ The report has been successfully removed.',
      })
    } else {
      res.status(404).json({
        success: false,
        message:
          'Sorry, no report found for the provided ID. Please verify the ID and try again.',
      })
    }
  },
)

export const changeReportStatus = asyncHandler(
  async (req: Request, res: Response) => {
    const reportId = req.params.id
    const { status } = req.body
    const validStatuses = ['complete', 'close', 'processing']

    if (!validStatuses.includes(status)) {
      res.status(400).json({
        success: false,
        message: `Invalid status value. Allowed values are: ${validStatuses.join(', ')}.`,
      })
      return
    }

    const result = await executeNonQuery(
      'UPDATE reports SET status = ? WHERE id = ?',
      [status, reportId],
    )
    const policeUserQuery = await executeQuery(
      'SELECT police_id FROM police_reports WHERE report_id = ? LIMIT 1',
      [reportId],
    )
    const data = policeUserQuery.data
    const police_id =
      Array.isArray(data) && data.length > 0 ? data[0]['police_id'] : undefined
    if (result.success && (result.affectedRows ?? 0) > 0) {
      await executeNonQuery(
        'INSERT INTO notification_police (type,police_id) VALUES (?,?)',
        ['report', police_id],
      )
      res.status(200).json({
        success: true,
        message: '✅ The report status has been successfully updated.',
      })
    } else {
      res.status(404).json({
        success: false,
        message:
          'No report found with the specified ID. Status update was not performed.',
      })
    }
  },
)

export const getAllReportTypes = asyncHandler(
  async (req: Request, res: Response) => {
    const result = await executeQuery('SELECT * FROM report_type')
    if (result.success && result.data) {
      res.status(200).json({
        success: true,
        data: result.data || [],
      })
    } else {
      res.status(404).json({
        success: false,
        message: 'No report types found.',
      })
    }
  },
)

export const createReportType = asyncHandler(
  async (req: Request, res: Response) => {
    const { name, point } = req.body
    const result = await executeNonQuery(
      'INSERT INTO report_type (name, point) VALUES (?, ?)',
      [name, point],
    )
    if (result.success && (result.affectedRows ?? 0) > 0) {
      res.status(201).json({
        success: true,
        message: '✅ The report type has been successfully created.',
      })
    } else {
      res.status(400).json({
        success: false,
        message: '❌ Failed to create the report type.',
      })
    }
  },
)
