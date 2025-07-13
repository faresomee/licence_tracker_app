import { body, param } from 'express-validator'

export const createAdminValidation = [
  body('name')
    .notEmpty()
    .withMessage('Name is required')
    .isString()
    .withMessage('Name must be a string')
    .trim()
    .isLength({ min: 2, max: 50 })
    .withMessage('Name must be between 2 and 50 characters'),

  body('email')
    .notEmpty()
    .withMessage('Email is required')
    .isEmail()
    .withMessage('Invalid email format')
    .normalizeEmail(),

  body('password_hash')
    .notEmpty()
    .withMessage('Password is required')
    .isString()
    .withMessage('Password must be a string')
    .isLength({ min: 6 })
    .withMessage('Password must be at least 6 characters long'),

  body('img_profile')
    .optional()
    .isString()
    .withMessage('Profile image must be a string'),

  body('role')
    .optional()
    .isString()
    .withMessage('Role must be a string')
    .isIn(['admin', 'superadmin'])
    .withMessage('Role must be either admin or superadmin'),

  body('status')
    .optional()
    .isString()
    .withMessage('Status must be a string')
    .isIn(['active', 'inactive'])
    .withMessage('Status must be either active or inactive'),
]

export const loginAdminValidation = [
  body('email')
    .notEmpty()
    .withMessage('Email is required')
    .isEmail()
    .withMessage('Invalid email format')
    .normalizeEmail(),

  body('password')
    .notEmpty()
    .withMessage('Password is required')
    .isString()
    .withMessage('Password must be a string')
    .isLength({ min: 6 })
    .withMessage('Password must be at least 6 characters long'),
]

export const updateAdminValidation = [
  body('name')
    .optional()
    .isString()
    .withMessage('Name must be a string')
    .trim()
    .isLength({ min: 2, max: 50 })
    .withMessage('Name must be between 2 and 50 characters'),

  body('email')
    .optional()
    .isEmail()
    .withMessage('Invalid email format')
    .normalizeEmail(),

  body('img_profile')
    .optional()
    .isString()
    .withMessage('Profile image must be a string'),

  body('status')
    .optional()
    .isString()
    .withMessage('Status must be a string')
    .isIn(['active', 'inactive'])
    .withMessage('Status must be either active or inactive'),
  body('password')
    .optional()
    .isString()
    .withMessage('Password must be a string')
    .isLength({ min: 6 })
    .withMessage('Password must be at least 6 characters long'),
]

export const createViolationAdmin = [
  body('police_id')
    .notEmpty()
    .withMessage('police_id is required')
    .isInt()
    .withMessage('police_id must be an integer'),

  body('plate_id')
    .notEmpty()
    .withMessage('plate_id is required')
    .isString()
    .withMessage('plate_id must be a string')
    .isLength({ max: 10 })
    .withMessage('plate_id cannot exceed 10 characters'),

  body('location')
    .notEmpty()
    .isString()
    .withMessage('location must be a string'),

  body('type')
    .notEmpty()
    .withMessage('type is required')
    .isInt()
    .withMessage('type must be an integer'),

  body('description')
    .notEmpty()
    .isString()
    .withMessage('description must be a string'),

  body('attachment')
    .optional()
    .isString()
    .withMessage('Attachment must be a string'),
]

export const changeStatusReport = [
  param('id')
    .isInt({ gt: 0 })
    .withMessage('Report ID must be a positive integer'),

  body('status')
    .isIn(['pending', 'accepted', 'rejected'])
    .withMessage('Status must be one of: pending, accepted, or rejected'),
]

export const changeStatusObjection = [
  param('id')
    .isInt({ gt: 0 })
    .withMessage('Report ID must be a positive integer'),

  body('status')
    .isIn(['pending', 'under_review', 'resolved', 'rejected', 'closed'])
    .withMessage(
      "Status must be one of: 'pending', 'under_review', 'resolved', 'rejected', or 'closed'",
    ),
]
