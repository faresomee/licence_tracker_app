export interface AdminUser {
  id?: number
  name: string
  img_profile?: string // insert it to DB
  email: string
  password?: string
  password_hash: string
  role?: string | null
  status?: string | null
  last_login?: Date | null
  created_at?: Date
  updated_at?: Date
}
