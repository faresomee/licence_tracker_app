import jwt from 'jsonwebtoken'
import { IUser } from '../model/default.user'
import { RowDataPacket } from 'mysql2'
import { extractJWTToken, validateJWTToken } from './police_user.access'
import { ForbiddenError, UnauthorizedError } from '../middleware/errorHandler'
import { NextFunction, Request, Response } from 'express'

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key'

export const validateUserToken = (
  req: Request,
  res: Response,
  next: NextFunction,
): void => {
  try {
    const token = extractJWTToken(req)
    if (!token) {
      return next(new UnauthorizedError('No token provided'))
    }

    const decoded = validateJWTToken(token)
    if (!decoded) {
      return next(new UnauthorizedError('Invalid token'))
    }

    ;(req as any).user_data = decoded
    next()
  } catch (error) {
    next(error)
  }
}

export const generateUserJWTToken = (user: IUser): string => {
  const tokenData = {
    id: user.national_id,
  }

  return jwt.sign(tokenData, JWT_SECRET, { expiresIn: '10h' })
}
