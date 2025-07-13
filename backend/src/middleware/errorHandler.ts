import { Request, Response, NextFunction } from 'express'
import logger from '../utils/logger'

export class ValidationError extends Error {
  constructor(
    message: string,
    public statusCode: number = 400,
  ) {
    super(message)
    this.name = 'ValidationError'
  }
}

export class NotFoundError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'NotFoundError'
  }
}

export class UnauthorizedError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'UnauthorizedError'
  }
}

export class ForbiddenError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'ForbiddenError'
  }
}

export const errorHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction,
): void => {
  const errorMeta = {
    path: req.path,
    method: req.method,
    ip: req.ip,
    errorName: err.name,
    stack: err.stack,
    userId: (req as any).user?.id || null,
    requestBody: req.body,
    requestQuery: req.query,
    requestParams: req.params,
  }

  if (err instanceof ValidationError) {
    logger.http('Validation Error', {
      ...errorMeta,
      statusCode: err.statusCode,
      errorType: 'ValidationError',
    })
    res.status(err.statusCode).json({
      error: {
        name: err.name,
        message: err.message,
        statusCode: err.statusCode,
      },
    })
    return
  }

  if (err instanceof NotFoundError) {
    logger.http('Not Found Error', {
      ...errorMeta,
      statusCode: 404,
      errorType: 'NotFoundError',
    })
    res.status(404).json({
      error: {
        name: err.name,
        message: err.message,
        statusCode: 404,
      },
    })
    return
  }

  if (err instanceof UnauthorizedError) {
    logger.http('Unauthorized Error', {
      ...errorMeta,
      statusCode: 401,
      errorType: 'UnauthorizedError',
    })
    res.status(401).json({
      error: {
        name: err.name,
        message: err.message,
        statusCode: 401,
      },
    })
    return
  }

  if (err instanceof ForbiddenError) {
    logger.http('Forbidden Error', {
      ...errorMeta,
      statusCode: 403,
      errorType: 'ForbiddenError',
    })
    res.status(403).json({
      error: {
        name: err.name,
        message: err.message,
        statusCode: 403,
      },
    })
    return
  }

  // For unexpected errors
  logger.http('Internal Server Error', {
    ...errorMeta,
    statusCode: 500,
    errorType: 'InternalServerError',
  })
  res.status(500).json({
    error: {
      name: 'InternalServerError',
      message: 'An unexpected error occurred',
      statusCode: 500,
    },
  })
}
