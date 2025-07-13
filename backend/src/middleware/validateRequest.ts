import { Request, Response, NextFunction } from 'express'
import { ValidationError } from './errorHandler'
import { validationResult } from 'express-validator'

export const validateRequest = (
  req: Request,
  res: Response,
  next: NextFunction,
): void => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map((error) => error.msg)
    throw new ValidationError(errorMessages.join(', '))
  }
  next()
}
