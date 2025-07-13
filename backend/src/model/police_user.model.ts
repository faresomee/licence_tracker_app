import { RowDataPacket } from 'mysql2'

export interface PoliceUser extends RowDataPacket {
  username: string
  image_profile: string
  rank: string
  department: string
  active: boolean
}
