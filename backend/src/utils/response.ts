import { QueryResult, RowDataPacket } from 'mysql2'
import { getHouers } from './dateFormat.util'
import { PoliceUserRow } from '../controller/admin.controller'
import { executeQuery, executeSingleQuery } from './orm.util'
import { violation } from '../model/police_user.response.model'
import { HomePage } from '../controller/Home.controller'
import { VehicleResponse } from '../model/user.model'

export const generateDescriptionForNotification = (
  typeOfNotification: string,
  reportId: string | null = null,
) => {
  if (typeOfNotification === 'password change') {
    return 'تم تحديث كلمة المرور,يرجى تذكرها'
  } else if (typeOfNotification === 'report') {
    return 'تم الرد على آخر تقرير لك، الرجاء المتابعة.'
  }
}

type VehicleData = {
  plate: string
  classification: string
  type: string
  name: string
  description: string
  created_at: string
}

type PersonData = {
  national_id: string
  criminal_status: number
  changed: string
}
type customeType = QueryResult[] | RowDataPacket[] | undefined
export const generateUrgentCard = (
  vehicle: customeType,
  person: customeType,
) => {
  if (person && vehicle) {
    const v = vehicle[0] as VehicleData
    const p = person[0] as PersonData
    if (v && p) {
      return {
        vehicle_card: {
          urgentName: 'مركبة مطلوبة',
          palteNumber: 'رقم اللوحة ' + v.plate,
          description: `${v.classification} ${v.type} ${v.name} - مطلوبة `,
          time: getHouers(v.created_at),
        },
        person_card: {
          urgentName: 'شخص مطلوب',
          national_id: 'الرقم القومي: ' + p.national_id,
          criminal_status: p.criminal_status === 1 ? 'مطلوب' : 'غير مطلوب',
          description: 'مطلوب أمنيًا ويجري البحث عنه.',
          time: getHouers(p.changed),
        },
      }
    } else if (v && !p) {
      return {
        vehicle_card: {
          urgentName: 'مركبة مطلوبة',
          palteNumber: 'رقم اللوحة ' + v.plate,
          description: `${v.classification} ${v.type} ${v.name} - مطلوبة `,
          time: getHouers(v.created_at),
        },
      }
    } else {
      return {
        person_card: {
          urgentName: 'شخص مطلوب',
          national_id: 'الرقم القومي: ' + p.national_id,
          criminal_status: p.criminal_status === 1 ? 'مطلوب' : 'غير مطلوب',
          description: 'مطلوب أمنيًا ويجري البحث عنه.',
          time: getHouers(p.changed),
        },
      }
    }
  }
}

type TicketData = {
  violation_type: string
  vehicle_name: string
  create_at: string
  violation_action: string
  plate: string
}
type InspectedData = {
  plate: string
  brand: string
  create_at: string
  name: string
}
type WantedVehicle = {
  plate: string
  description: string
  created_at: string
}
export const generateActivitesCard = (
  ticket: customeType,
  check: customeType,
  wanted_vehicle: customeType,
) => {
  if (ticket && check) {
    const t = ticket[0] as TicketData
    const v = check[0] as InspectedData
    const w = wanted_vehicle ? (wanted_vehicle[0] as WantedVehicle) : undefined
    if (!v && !w) {
      return {
        activites_card: {
          ticket: 'مخالفة ' + t.violation_type,
          description: t.plate + t.vehicle_name,
          action: t.violation_action,
          time: getHouers(t.create_at),
        },
        inspected: {},
      }
    }
    return {
      activites_card: {
        ticket: 'مخالفة ' + t.violation_type,
        description: t.plate + t.vehicle_name,
        action: t.violation_action,
        time: getHouers(t.create_at),
      },
      inspected: {
        type: 'فحص روتيني',
        vehicle_name: v.name + ' ' + v.plate,
        status: w === undefined ? 'سليمة' : 'مطلوبة',
        time: getHouers(v.create_at),
      },
    }
  } else {
    return {}
  }
}

const formatViolations = (
  violations: Partial<violation> | Partial<violation>[],
): { caseSolved: number; activeCase: number; pendingCase: number } => {
  const list = Array.isArray(violations) ? violations : [violations]

  let caseSolved = 0
  let activeCase = 0
  let pendingCase = 0

  for (const vio of list) {
    switch (vio.violation_status) {
      case 'paied':
        ++caseSolved
        break
      case 'unpaied':
        ++activeCase
        break
      case 'under_review':
        ++pendingCase
        break
    }
  }

  return {
    caseSolved,
    activeCase,
    pendingCase,
  }
}

export const HandelViolations = async (policeData: PoliceUserRow) => {
  const police_id = policeData.id

  const spesific_violations = await executeQuery<violation>(
    `
SELECT 
  v.plate_id as plate_number ,
  v.location as location ,
  vt.name as violation ,
  v.status as violation_status ,
  v.id as violation_id
FROM violations v 
INNER JOIN violation_type vt ON vt.ID = v.type
WHERE v.police_id = ?`,
    [police_id],
  )
  if (spesific_violations && spesific_violations.data) {
    const statstic_data = formatViolations(spesific_violations.data)
    return {
      sucess: true,
      statistics: statstic_data,
      total: spesific_violations.data.length,
      data: spesific_violations.data,
    }
  } else {
    return {
      sucess: false,
      total: 0,
      data: {},
    }
  }
}

export const HandelAttachmets = (
  attachments: string | string[] | null,
  protocol: string,
  host: string | undefined,
  fileName?: string,
): string[] => {
  const baseUrl = `${protocol}://${host}/uploads/images/${fileName || 'violation_ticket'}/`

  if (!attachments) return []

  let files: string[] = []

  if (typeof attachments === 'string') {
    try {
      files = JSON.parse(attachments)
      if (!Array.isArray(files)) {
        files = attachments.split(',')
      }
    } catch {
      files = attachments.split(',')
    }
  } else if (Array.isArray(attachments)) {
    files = attachments
  }

  return files.map((file) => baseUrl + file.trim())
}

export const HandelStatistics = (items: HomePage | undefined) => {
  let Total_Violations = items?.Total_Violations || 0
  let detected_violation = items?.detected_violation || 0
  let under_investigation = items?.under_investigation || 0
  return {
    Total_Violations,
    detected_violation,
    under_investigation,
  }
}
