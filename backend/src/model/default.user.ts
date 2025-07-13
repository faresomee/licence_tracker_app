import { RowDataPacket } from 'mysql2'

export interface IUser extends RowDataPacket {
  national_id: string
  full_name?: string | null
  gender?: 'ذكر' | 'انثى' | null
  date_of_birth?: string | null
  social_status?: 'عازب' | 'مطلق' | 'متزوج' | 'ارملة' | null
  religion?: string | null
  address?: string | null
  issue_date?: string | null
  expired_date?: string | null
  criminal_status?: boolean | 0 | 1 | null
  changed?: string
}
