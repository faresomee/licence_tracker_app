import { body } from 'express-validator'

export const validateWantedVehicle = [
  body('plate')
    .trim()
    .notEmpty()
    .withMessage('Plate is required')
    .isLength({ min: 3 })
    .withMessage('Plate must be at least 3 characters'),

  body('location').trim().notEmpty().withMessage('Location is required'),

  body('description').trim().notEmpty().withMessage('Description is required'),
]
