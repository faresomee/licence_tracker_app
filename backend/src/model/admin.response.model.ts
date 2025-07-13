import { RowDataPacket } from 'mysql2'
import { AdminUser } from './admin_user.model'

export interface AdminResponse {
  id: number
  name: string
  email: string
  role?: string | null
  status?: string | null
  img_profile?: string | null
  last_login?: Date | null
  created_at?: Date
  updated_at?: Date
}

export interface AdminListResponse {
  data: AdminResponse[]
  pagination: {
    total: number
    page: number
    limit: number
    totalPages: number
  }
}
export interface ResponseCounted extends RowDataPacket {
  total: number
}
