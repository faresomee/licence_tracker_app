import asyncHandler from '../middleware/asyncHandler'
import { Request, Response } from 'express'
import { executeQuery } from '../utils/orm.util'
import { RowDataPacket } from 'mysql2'
import { ResponseCounted } from '../model/admin.response.model'

export const getAllWantedVehicle = asyncHandler(
  async (req: Request, res: Response) => {
    const page = parseInt(req.query.page as string) || 1
    const limit = parseInt(req.query.limit as string) || 10
    const offset = (page - 1) * limit

    const countQuery = `SELECT COUNT(*) as total FROM wanted_vehicle`
    const countResult = await executeQuery<ResponseCounted>(countQuery, [])
    let total = 0
    if (countResult && countResult.data) {
      total = countResult.data[0].total
    }

    const dataQuery = `
    SELECT id,plate, location, description, created_at
    FROM wanted_vehicle
    ORDER BY created_at DESC
    LIMIT ? OFFSET ?
  `
    const data = await executeQuery(dataQuery, [limit, offset])

    res.json({
      data,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    })
  },
)

export const getSpesificVehicle = asyncHandler(
  async (req: Request, res: Response) => {
    const { id } = req.params

    const query = `SELECT * FROM wanted_vehicle WHERE id = ? LIMIT 1`
    const results = await executeQuery(query, [id])

    if (results && results.data) {
      res.status(200).json(results.data ? results.data[0] : results.data)
    }
  },
)

export const AddWantedVhecile = asyncHandler(
  async (req: Request, res: Response) => {
    const { plate, location, description } = req.body

    const insertQuery = `
    INSERT INTO wanted_vehicle (plate, location, description)
    VALUES (?, ?, ?)
  `

    const result = await executeQuery(insertQuery, [
      plate,
      location,
      description,
    ])

    res.status(201).json({
      message: 'Wanted vehicle added successfully',
    })
  },
)

export const deleteWantedVehcile = asyncHandler(
  async (req: Request, res: Response) => {
    const { id } = req.params

    const checkQuery = `SELECT * FROM wanted_vehicle WHERE id = ?`
    const result = await executeQuery<ResponseCounted>(checkQuery, [id])

    let total = 0
    if (result && result.data) {
      total = result.data[0].total
    }

    const deleteQuery = `DELETE FROM wanted_vehicle WHERE id = ?`
    await executeQuery(deleteQuery, [id])

    res.json({ message: 'Wanted vehicle deleted successfully' })
  },
)
