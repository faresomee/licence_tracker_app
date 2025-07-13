import { executeSingleQuery } from '../utils/orm.util'
import { AdminUser } from '../model/admin_user.model'
import jwt from 'jsonwebtoken'
import { RowDataPacket } from 'mysql2'
import dotenv from 'dotenv'
import { UnauthorizedError } from '../middleware/errorHandler'
import { Request } from 'express'

dotenv.config()

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key'

interface AdminUserRow extends AdminUser, RowDataPacket {}

export async function isAdminExist(email: string): Promise<AdminUser | false> {
  try {
    const result = await executeSingleQuery<AdminUserRow>(
      'SELECT * FROM admin_users WHERE email = ?',
      [email],
    )
    return result.success && result.data && result.data.length > 0
      ? result.data[0]
      : false
  } catch (error) {
    console.error('Error checking admin existence:', error)
    return false
  }
}

export const extractAdminJWTToken = (req: any): string | null => {
  const authHeader = req.headers.authorization
  if (!authHeader) {
    throw new UnauthorizedError(
      'Authorization header is missing. Please provide a valid token.',
    )
  }

  const [bearer, token] = authHeader.split(' ')
  if (bearer !== 'Bearer' || !token) {
    throw new UnauthorizedError(
      'Invalid authorization header format. Expected format: Bearer <token>',
    )
  }

  return token
}

export const validateAdminJWTToken = (token: string): any => {
  try {
    return jwt.verify(token, JWT_SECRET)
  } catch (error) {
    if (error instanceof jwt.TokenExpiredError) {
      throw new UnauthorizedError('Token has expired. Please login again.')
    }
    if (error instanceof jwt.JsonWebTokenError) {
      throw new UnauthorizedError(
        'Invalid token. Please provide a valid authentication token.',
      )
    }
    throw new UnauthorizedError('Failed to verify token. Please try again.')
  }
}

export async function checkAdminPrivilege(
  adminId: number,
  requiredRole: string,
): Promise<boolean> {
  try {
    const result = await executeSingleQuery<AdminUserRow>(
      'SELECT role FROM admin_users WHERE id = ?',
      [adminId],
    )
    if (!result.success || !result.data || result.data.length === 0)
      return false

    const adminRole = result.data[0].role
    return adminRole === requiredRole
  } catch (error) {
    console.error('Error checking admin privilege:', error)
    return false
  }
}

export async function isSuperAdmin(adminId: number): Promise<boolean> {
  return checkAdminPrivilege(adminId, 'superadmin')
}

export async function isAdmin(adminId: number): Promise<boolean> {
  return checkAdminPrivilege(adminId, 'admin')
}

export function generateAdminJWTToken(admin: AdminUser, req: Request): string {
  return jwt.sign(
    {
      id: admin.id,
      email: admin.email,
      role: admin.role,
      name: admin.name,
      img_profile:
        req.protocol +
        '://' +
        req.get('host') +
        '/uploads/images/admin_users/' +
        admin.img_profile,
    },
    JWT_SECRET,
    { expiresIn: '24h' },
  )
}
