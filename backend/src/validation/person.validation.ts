import { body, param } from 'express-validator'

export const PersonValidation = [
  param('id')
    .notEmpty()
    .withMessage('ID is required')
    .isInt()
    .withMessage('ID must be an integer')
    .trim()
    .isLength({ min: 14, max: 14 })
    .withMessage('ID must be 14 characters long'),
]

export const PersonCriminalStatusValidation = [
  body('criminal_status')
    .notEmpty()
    .withMessage('Criminal status is required')
    .isIn(['0', '1'])
    .withMessage('Criminal status must be either 0 or 1')
    .trim(),
]
