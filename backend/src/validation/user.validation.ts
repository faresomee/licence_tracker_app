import { body } from 'express-validator'

export const validateUser = [
  body('national_id')
    .notEmpty()
    .withMessage('National ID is required.')
    .isLength({ min: 14, max: 14 })
    .withMessage('National ID must be exactly 14 digits.')
    .matches(/^[0-9]{14}$/)
    .withMessage('National ID must contain only numbers.'),

  body('email')
    .notEmpty()
    .withMessage('Email is required.')
    .isEmail()
    .withMessage('Invalid email address.')
    .normalizeEmail(),

  body('password')
    .notEmpty()
    .withMessage('Password is required.')
    .isLength({ min: 5, max: 20 })
    .withMessage('Password must be between 5 and 20 characters.'),
]

export const validateUserLogin = [
  body('email')
    .notEmpty()
    .withMessage('Email is required.')
    .isEmail()
    .withMessage('Invalid email address.')
    .normalizeEmail(),

  body('password')
    .notEmpty()
    .withMessage('Password is required.')
    .isLength({ min: 5, max: 20 })
    .withMessage('Password must be between 5 and 20 characters.'),
]

export const userReportValidation = [
  body('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required.')
    .isLength({ max: 100 })
    .withMessage('Name must be at most 100 characters.'),

  body('phone').trim().notEmpty().withMessage('Phone is required.'),

  body('address')
    .trim()
    .notEmpty()
    .withMessage('Address is required.')
    .isLength({ max: 255 })
    .withMessage('Address must be at most 255 characters.'),

  body('date')
    .trim()
    .notEmpty()
    .withMessage('Date is required.')
    .isISO8601()
    .withMessage('Date must be in a valid ISO 8601 format (e.g. YYYY-MM-DD).'),

  body('vehcile_types')
    .trim()
    .notEmpty()
    .withMessage('Vehicle types are required.')
    .isLength({ max: 300 })
    .withMessage('Vehicle types must be at most 300 characters.'),

  body('description').trim().notEmpty().withMessage('Description is required.'),

  body('attachment')
    .optional()
    .isString()
    .withMessage('Attachment must be a string'),
]
export const validateUserObjection = [
  body('report_id')
    .isNumeric()
    .withMessage('report_id must contain only numbers'),

  body('description')
    .isString()
    .withMessage('description must be a string')
    .notEmpty()
    .withMessage('description is required'),
]
