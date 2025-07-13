import asyncHandler from '../middleware/asyncHandler'
import { Request, Response } from 'express'
import { executeQuery } from '../utils/orm.util'
import {
  saveUploadedFile,
  saveUploadedFiles,
} from '../middleware/multer.middleware'
import { formatDateV2 } from '../utils/dateFormat.util'

export const createVehicleTicket = asyncHandler(
  async (req: Request, res: Response) => {
    const user = (req as any).user

    let attachmentPaths: string[] = []

    if (req.files && Array.isArray(req.files) && req.files.length > 0) {
      const savedFiles = await saveUploadedFiles(req)
      attachmentPaths = savedFiles.map((filename) => `${filename}`)
      const query = `
        INSERT INTO violations 
        (police_id, plate_id, location, type, action, description, attachments , status )
        VALUES (?, ?, ?, ?, ?, ?,?,?)
      `
      const values = [
        user.id,
        req.body.vehicle_plate,
        req.body.location,
        req.body.violation_type,
        req.body.action_taken,
        req.body.description,
        JSON.stringify(attachmentPaths),
        req.body.status,
      ]
      await executeQuery(query, values)
    } else {
      const query = `
            INSERT INTO violations 
            (police_id, plate_id, location, type, action, description , status )
            VALUES (?, ?, ?, ?, ?, ?,?)
        `
      const values = [
        user.id,
        req.body.vehicle_plate,
        req.body.location,
        req.body.violation_type,
        req.body.action_taken,
        req.body.description,
        req.body.status || '',
      ]
      await executeQuery(query, values)
    }

    res.status(201).json({ success: true, message: 'Ticket created' })
  },
)

export const getAllViolationTicket = asyncHandler(
  async (req: Request, res: Response) => {
    const query = `SELECT * FROM violation_type`
    const result = await executeQuery(query)
    res.status(200).json({
      data: result,
    })
  },
)

export const getAllViolationTicketActions = asyncHandler(
  async (req: Request, res: Response) => {
    const query = `SELECT * FROM violation_action`
    const result = await executeQuery(query)
    res.status(200).json({
      data: result,
    })
  },
)

export const searchForViolationsOnVehicle = asyncHandler(
  // here
  async (req: Request, res: Response) => {
    const plate_id = req.params.plate_id
    const searchForViolations = `SELECT 
vt.name,
v.create_at,
v.status
FROM violations v
JOIN violation_type vt ON vt.ID = v.type
WHERE v.plate_id = ?
;`
    const searchForMoreInformation = `SELECT 
v.plate,
vl.color,
v.glass_type
FROM vehicle_license vl 
JOIN vehicle v ON vl.vehicle_plate = v.plate
WHERE v.plate = ?;`
    const getDateOflicense = `SELECT 
vl.issue_date,
vl.expiry_date,
vl.inspection_date
FROM vehicle_license vl
WHERE vl.vehicle_plate = ?
;`
    const vehicleInformationQuery = `SELECT 
veh.brand,
veh.name,
veh.chassis_number,
veh.engine_number
FROM vehicle veh
WHERE veh.plate = ?
;`
    const trafficInformationQuery = `SELECT 
    drl.traffic_department,
    drl.traffic_office,
    p.full_name,
    p.address
FROM driver_license drl
JOIN person p ON drl.driver_id = p.national_id
JOIN vehicle_license vl ON vl.driving_license_id = drl.number
WHERE vl.vehicle_plate = ?;
`
    const violationData = await executeQuery(searchForViolations, [plate_id])
    const vehicleData = await executeQuery(searchForMoreInformation, [plate_id])
    const licenseData = await executeQuery(getDateOflicense, [plate_id])
    const vehicleInformation = await executeQuery(vehicleInformationQuery, [
      plate_id,
    ])
    const traffic_infortmation = await executeQuery(trafficInformationQuery, [
      plate_id,
    ])

    const licenseDataResult = Array.isArray(licenseData.data)
      ? licenseData.data.map((license) => {
          return {
            ...license,
            issue_date: formatDateV2(license.issue_date),
            expiry_date: formatDateV2(license.expiry_date),
            inspection_date: formatDateV2(license.inspection_date),
          }
        })
      : []
    const result = {
      traffic_information: traffic_infortmation,
      vehicleInformation: vehicleInformation.data,
      vehicle: vehicleData.data,
      dates: licenseDataResult,
      violation: violationData.data,
    }
    res.status(200).json({
      data: result,
    })
  },
)
