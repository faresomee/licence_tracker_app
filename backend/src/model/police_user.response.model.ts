import { RowDataPacket } from 'mysql2'
import { User } from './user.model'

export interface PoliceUserResponse {
  id: number
  badgeNum: string
  name: string
  rank_id: string
  department: string
  city: string
  active: boolean
  online: boolean
  username: string
  phone_number?: string | null
  img_profile?: string | null
  last_login?: Date | null
  created_at?: Date
  updated_at?: Date
  violations?: [] | any
}
export interface violation extends RowDataPacket {
  plate_number: number
  location: string
  violation_status: string
  violation_id: number
}
export interface PoliceUserListResponse {
  data: PoliceUserResponse[]
  pagination: {
    total: number
    page: number
    limit: number
    totalPages: number
  }
}
