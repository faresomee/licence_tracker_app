import { RowDataPacket } from 'mysql2'

export interface User extends RowDataPacket {
  id: number
  name: string
  last_login?: Date | null
  active?: boolean
  username: string
  password_hash: string
  role_id: number
  phone_number?: string | null
  img_profile?: string | null
  created_at?: Date
  updated_at?: Date
}

export interface VehicleResponse extends RowDataPacket {
  success: boolean
  data: {
    plate: string
    brand: string
    name: string
    type: string
    chassis_number: string
    engine_number: string
    glass_type: string
    classification: string
    model: number
    is_wanted: number
    violations: {
      id: number
      type: number
      action: number
      status: string
      location: string
      created_at: string // or Date if parsed
      description: string
    }[]
  }[]
}
