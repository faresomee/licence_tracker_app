"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.changeStatusObjection = exports.changeStatusReport = exports.createViolationAdmin = exports.updateAdminValidation = exports.loginAdminValidation = exports.createAdminValidation = void 0;
const express_validator_1 = require("express-validator");
exports.createAdminValidation = [
    (0, express_validator_1.body)('name')
        .notEmpty()
        .withMessage('Name is required')
        .isString()
        .withMessage('Name must be a string')
        .trim()
        .isLength({ min: 2, max: 50 })
        .withMessage('Name must be between 2 and 50 characters'),
    (0, express_validator_1.body)('email')
        .notEmpty()
        .withMessage('Email is required')
        .isEmail()
        .withMessage('Invalid email format')
        .normalizeEmail(),
    (0, express_validator_1.body)('password_hash')
        .notEmpty()
        .withMessage('Password is required')
        .isString()
        .withMessage('Password must be a string')
        .isLength({ min: 6 })
        .withMessage('Password must be at least 6 characters long'),
    (0, express_validator_1.body)('img_profile')
        .optional()
        .isString()
        .withMessage('Profile image must be a string'),
    (0, express_validator_1.body)('role')
        .optional()
        .isString()
        .withMessage('Role must be a string')
        .isIn(['admin', 'superadmin'])
        .withMessage('Role must be either admin or superadmin'),
    (0, express_validator_1.body)('status')
        .optional()
        .isString()
        .withMessage('Status must be a string')
        .isIn(['active', 'inactive'])
        .withMessage('Status must be either active or inactive'),
];
exports.loginAdminValidation = [
    (0, express_validator_1.body)('email')
        .notEmpty()
        .withMessage('Email is required')
        .isEmail()
        .withMessage('Invalid email format')
        .normalizeEmail(),
    (0, express_validator_1.body)('password')
        .notEmpty()
        .withMessage('Password is required')
        .isString()
        .withMessage('Password must be a string')
        .isLength({ min: 6 })
        .withMessage('Password must be at least 6 characters long'),
];
exports.updateAdminValidation = [
    (0, express_validator_1.body)('name')
        .optional()
        .isString()
        .withMessage('Name must be a string')
        .trim()
        .isLength({ min: 2, max: 50 })
        .withMessage('Name must be between 2 and 50 characters'),
    (0, express_validator_1.body)('email')
        .optional()
        .isEmail()
        .withMessage('Invalid email format')
        .normalizeEmail(),
    (0, express_validator_1.body)('img_profile')
        .optional()
        .isString()
        .withMessage('Profile image must be a string'),
    (0, express_validator_1.body)('status')
        .optional()
        .isString()
        .withMessage('Status must be a string')
        .isIn(['active', 'inactive'])
        .withMessage('Status must be either active or inactive'),
    (0, express_validator_1.body)('password')
        .optional()
        .isString()
        .withMessage('Password must be a string')
        .isLength({ min: 6 })
        .withMessage('Password must be at least 6 characters long'),
];
exports.createViolationAdmin = [
    (0, express_validator_1.body)('police_id')
        .notEmpty()
        .withMessage('police_id is required')
        .isInt()
        .withMessage('police_id must be an integer'),
    (0, express_validator_1.body)('plate_id')
        .notEmpty()
        .withMessage('plate_id is required')
        .isString()
        .withMessage('plate_id must be a string')
        .isLength({ max: 10 })
        .withMessage('plate_id cannot exceed 10 characters'),
    (0, express_validator_1.body)('location')
        .notEmpty()
        .isString()
        .withMessage('location must be a string'),
    (0, express_validator_1.body)('type')
        .notEmpty()
        .withMessage('type is required')
        .isInt()
        .withMessage('type must be an integer'),
    (0, express_validator_1.body)('description')
        .notEmpty()
        .isString()
        .withMessage('description must be a string'),
    (0, express_validator_1.body)('attachment')
        .optional()
        .isString()
        .withMessage('Attachment must be a string'),
];
exports.changeStatusReport = [
    (0, express_validator_1.param)('id')
        .isInt({ gt: 0 })
        .withMessage('Report ID must be a positive integer'),
    (0, express_validator_1.body)('status')
        .isIn(['pending', 'accepted', 'rejected'])
        .withMessage('Status must be one of: pending, accepted, or rejected'),
];
exports.changeStatusObjection = [
    (0, express_validator_1.param)('id')
        .isInt({ gt: 0 })
        .withMessage('Report ID must be a positive integer'),
    (0, express_validator_1.body)('status')
        .isIn(['pending', 'under_review', 'resolved', 'rejected', 'closed'])
        .withMessage("Status must be one of: 'pending', 'under_review', 'resolved', 'rejected', or 'closed'"),
];
