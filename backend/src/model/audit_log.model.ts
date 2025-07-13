export interface AuditLog {
  id: number
  user_id: number
  action: string
  timestamp?: Date
}
