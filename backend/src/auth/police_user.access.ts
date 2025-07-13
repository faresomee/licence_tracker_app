import { executeSingleQuery } from '../utils/orm.util'
import { User } from '../model/user.model'
import jwt from 'jsonwebtoken'
import { UnauthorizedError } from '../middleware/errorHandler'
import { NextFunction, Request, Response } from 'express'
import { PoliceUser } from '../model/police_user.model'

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key'

export async function isPoliceUserExist(
  username: string,
): Promise<User | false> {
  try {
    const result = await executeSingleQuery<User>(
      'SELECT * FROM police_users WHERE username = ?',
      [username],
    )
    return result.success && result.data && result.data.length > 0
      ? result.data[0]
      : false
  } catch (error) {
    console.error('Error checking user existence:', error)
    return false
  }
}

export const extractJWTToken = (req: any): string => {
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

export const validateJWTToken = (token: string): any => {
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

export const validatePoliceToken = (
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

    ;(req as any).user = decoded
    next()
  } catch (error) {
    next(error)
  }
}

export const generatePoliceUserJWTToken = (
  policeUser: PoliceUser,
  req: Request,
): string => {
  const tokenData = {
    id: policeUser.id,
    img_profile:
      req.protocol +
      '://' +
      req.get('host') +
      '/uploads/images/police_users/' +
      policeUser.img_profile,
    username: policeUser.username,
    name: policeUser.name,
    rank: policeUser.rank,
    department: policeUser.department,
    city: policeUser.city,
  }

  return jwt.sign(tokenData, JWT_SECRET, { expiresIn: '10h' })
}
