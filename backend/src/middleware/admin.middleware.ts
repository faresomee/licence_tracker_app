import { Request, Response, NextFunction } from 'express'
import { extractJWTToken, validateJWTToken } from '../auth/police_user.access'
import { isAdmin, isSuperAdmin } from '../auth/admin.access'
import {
  UnauthorizedError,
  ForbiddenError,
  ValidationError,
} from './errorHandler'

interface JWTDecoded {
  id: number
  username: string
  role_id: number
}

interface ResponseWithUser extends Response {
  locals: {
    user?: JWTDecoded
  }
}

export const validateAdminToken = async (
  req: Request,
  res: ResponseWithUser,
  next: NextFunction,
): Promise<void> => {
  try {
    const token = extractJWTToken(req)
    if (!token) {
      throw new UnauthorizedError('No token provided')
    }

    const decoded = validateJWTToken(token) as JWTDecoded
    if (!decoded || !decoded.id) {
      throw new UnauthorizedError('Invalid token format')
    }

    const isUserAdmin = await isAdmin(decoded.id)
    const isUserSuperAdmin = await isSuperAdmin(decoded.id)
    if (!isUserAdmin && !isUserSuperAdmin) {
      throw new ForbiddenError('Access denied. Admin privileges required.')
    }

    res.locals.user = decoded
    next()
  } catch (error) {
    next(error)
  }
}

export const validateAdminId = (
  req: Request,
  res: Response,
  next: NextFunction,
): void => {
  try {
    const { id } = req.params
    const adminId = parseInt(id)

    if (isNaN(adminId) || adminId <= 0) {
      throw new ValidationError('Invalid admin ID format')
    }

    req.params.id = adminId.toString()
    next()
  } catch (error) {
    next(error)
  }
}
