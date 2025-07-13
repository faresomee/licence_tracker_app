import { formatDateV2, getRealTime } from '../utils/dateFormat.util'
import { executeNonQuery, executeQuery } from '../utils/orm.util'

export async function CheckVehicleRealTime(
  uname_police: string,
  plate: string,
  user_id: number,
) {
  //Check IN Redis DB if thisPlate Number Is Checked Before !

  await executeNonQuery(
    'INSERT INTO inspected_vehicles (plate , police_id) VALUES(?,?);',
    [plate, user_id],
  )

  const currentTime = new Date()
  const isWantedVehcile = await executeQuery(
    "SELECT COUNT(*) as 'wanted' FROM wanted_vehicle WHERE plate =?  ",
    [plate],
  )
  const isDriverWanted = await executeQuery(
    `SELECT
    p.criminal_status
FROM
    vehicle_license vl
JOIN driver_license dl ON
    vl.driving_license_id = dl.number
INNER JOIN person p ON
    p.national_id = dl.driver_id
WHERE
    vehicle_plate = ?;`,
    [plate],
  )

  const isVehcileHaveManyViolations = await executeQuery(
    "SELECT SUM(vt.score) AS total FROM violations v JOIN violation_type vt ON v.type = vt.ID WHERE plate_id = ? AND status = 'unpaied';",
    [plate],
  )

  if (isWantedVehcile.data) {
    const wantedVehcile = isWantedVehcile.data[0].wanted
    if (wantedVehcile > 0) {
      return {
        plate,
        status: 'مطلوبة',
        timestamp: getRealTime(currentTime.toString()),
      }
    }

    if (isDriverWanted.data) {
      const driverWanted = isDriverWanted.data[0].criminal_status
      if (driverWanted > 0) {
        return {
          plate,
          status: 'مطارد',
          timestamp: getRealTime(currentTime.toString()),
        }
      }

      if (isVehcileHaveManyViolations.data) {
        const HaveMenyViolation = isVehcileHaveManyViolations.data[0].total
        if (HaveMenyViolation > 50) {
          // if SCORE > 50 then veh will BE WANTED
          return {
            plate,
            status: 'مطلوبة',
            timestamp: getRealTime(currentTime.toString()),
          }
        }
      }
    }
  }

  return {
    plate,
    status: 'سليمة',
    timestamp: getRealTime(currentTime.toString()),
  }
}
