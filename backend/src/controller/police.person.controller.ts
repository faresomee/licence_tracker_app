import asyncHandler from '../middleware/asyncHandler'
import { Request, Response } from 'express'
import { executeQuery } from '../utils/orm.util'
import { formatDateV2, validDate } from '../utils/dateFormat.util'

export const getLicnseByID = asyncHandler(
  async (req: Request, res: Response) => {
    const { id } = req.params
    const query = `SELECT
    vl.color AS "Vehicle_color",
    p.full_name AS "Person_full_name",
    p.address AS "Person_address",
    vl.vehicle_plate AS "Plate_Number",
    vl.type AS "Vehicle_license_type",
    vl.inspection_date AS "Vehicle_inspection_date",
    veh.brand AS "Vehicle_brand",
    veh.type AS "Vehicle_body_type",
    veh.classification AS "Vehicle_classification",
    veh.name AS "Vehicle_name",
    veh.model AS "Vehicle_model",
    dl.driver_id AS "Person_national_id",
    lt.type_name AS "Driving_license_type",
    dl.education AS "Person_education",
    dl.nationality AS "Person_nationality",
    dl.number AS "Driving_license_id",
    dl.issue_date,
    dl.expiry_date,
    dl.traffic_department,
    dl.traffic_office
FROM
    vehicle_license AS vl
INNER JOIN vehicle AS veh
    ON veh.plate = vl.vehicle_plate
INNER JOIN driver_license AS dl
    ON dl.number = vl.driving_license_id
INNER JOIN license_types AS lt
    ON lt.code = dl.type
INNER JOIN person AS p 
    ON p.national_id = dl.driver_id
WHERE
    vl.driving_license_id = ?;`

    const person = await executeQuery(query, [id])
    if (person.data?.length === 0) {
      res
        .status(404)
        .json({ message: 'لم يتم العثور على بيانات الرخصة المطلوبة.' })
    }
    const personData = person.data
      ? person.data.map((person) => {
          return {
            person: {
              id: person.Person_national_id,
              name: person.Person_full_name,
              address: person.Person_address,
              education: person.Person_education,
              nationality: person.Person_nationality,
            },
            vehicle: {
              classification: person.Vehicle_type,
              plate: person.Plate_Number,
              name: person.Vehicle_name, //
              model: person.Vehicle_model,
              color: person.Vehicle_color,
              brand: person.Vehicle_brand,
              type: person.type_of_vehicle_license,
            },
            license: {
              id: person.Driving_license_id,
              valid: validDate(person.expiry_date),
              type: person.Vehicle_license_type,
              traffic_department: person.traffic_department,
              traffic_office: person.traffic_office,
              issue_date: formatDateV2(person.issue_date),
              expiry_date: formatDateV2(person.expiry_date),
              inspection_date: formatDateV2(person.Vehicle_inspection_date),
            },
          }
        })
      : []
    res.status(200).json({ information: personData })
  },
)
