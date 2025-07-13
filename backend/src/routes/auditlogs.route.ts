import { Router } from 'express'
import { Request, Response } from 'express'
import { executeQuery } from '../utils/orm.util'
import { RowDataPacket } from 'mysql2'

interface CountResult extends RowDataPacket {
  'COUNT(*)': number
}

const router = Router()

router.get('/', async function (req: Request, res: Response) {
  try {
    const { page, limit } = req.query
    const pageNumber = parseInt(page as string) || 1
    const limitNumber = parseInt(limit as string) || 10
    const offset = (pageNumber - 1) * limitNumber

    const query = `SELECT * FROM AuditLogs ORDER BY created_at DESC LIMIT ${limitNumber} OFFSET ${offset}`
    const auditLogs = await executeQuery(query)

    const totalQuery = `SELECT COUNT(*) FROM AuditLogs`
    const totalResult = await executeQuery<CountResult>(totalQuery)

    res.status(200).json({
      data: auditLogs,
      total: totalResult.data?.[0]?.['COUNT(*)'] || 0,
      page: pageNumber,
      limit: limitNumber,
    })
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch audit logs ' + error })
  }
})

export default router
