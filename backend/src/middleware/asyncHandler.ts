import { Request, Response, NextFunction } from 'express'

const asyncHandler = (
  route: (req: Request, res: Response, next: NextFunction) => Promise<void>,
) => {
  return async (
    req: Request,
    res: Response,
    next: NextFunction,
  ): Promise<void> => {
    try {
      await route(req, res, next)
    } catch (error) {
      next(error)
    }
  }
}

export default asyncHandler
