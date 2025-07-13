"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.changePasswordForPoliceUserValidation = exports.generateOTPForLogin = exports.loginPoliceUserValidation = exports.updatePoliceUserValidation = exports.createPoliceUserValidation = void 0;
const express_validator_1 = require("express-validator");
exports.createPoliceUserValidation = [
    (0, express_validator_1.body)('military_id')
        .notEmpty()
        .withMessage('Military ID is required')
        .isString()
        .withMessage('Military ID must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Military ID must not be empty'),
    (0, express_validator_1.body)('name')
        .notEmpty()
        .withMessage('Name is required')
        .isString()
        .withMessage('Name must be a string')
        .trim()
        .isLength({ min: 2, max: 50 })
        .withMessage('Name must be between 2 and 50 characters'),
    (0, express_validator_1.body)('rank_id')
        .notEmpty()
        .withMessage('Rank is required')
        .isString()
        .withMessage('Rank must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Rank must not be empty'),
    (0, express_validator_1.body)('department')
        .notEmpty()
        .withMessage('Department is required')
        .isString()
        .withMessage('Department must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Department must not be empty'),
    (0, express_validator_1.body)('active')
        .notEmpty()
        .withMessage('Active status is required')
        .isBoolean()
        .withMessage('Active must be a boolean value'),
    (0, express_validator_1.body)('username')
        .notEmpty()
        .withMessage('Username is required')
        .isString()
        .withMessage('Username must be a string')
        .trim()
        .isLength({ min: 3, max: 20 })
        .withMessage('Username must be between 3 and 20 characters')
        .matches(/^[a-zA-Z0-9_]+$/)
        .withMessage('Username can only contain letters, numbers, and underscores'),
    (0, express_validator_1.body)('password')
        .notEmpty()
        .withMessage('Password is required')
        .isString()
        .withMessage('Password must be a string')
        .isLength({ min: 6 })
        .withMessage('Password must be at least 6 characters long'),
    (0, express_validator_1.body)('city')
        .notEmpty()
        .withMessage('City is required')
        .isString()
        .withMessage('City must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('City must not be empty'),
    (0, express_validator_1.body)('phone_number')
        .optional()
        .isString()
        .withMessage('Phone number must be a string')
        .trim()
        .matches(/^\+?[0-9]{10,15}$/)
        .withMessage('Phone number must be a valid format'),
    (0, express_validator_1.body)('img_profile')
        .optional()
        .isString()
        .withMessage('Profile image must be a string'),
];
exports.updatePoliceUserValidation = [
    (0, express_validator_1.body)('military_id')
        .optional()
        .isString()
        .withMessage('Military ID must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Military ID must not be empty'),
    (0, express_validator_1.body)('name')
        .optional()
        .isString()
        .withMessage('Name must be a string')
        .trim()
        .isLength({ min: 2, max: 50 })
        .withMessage('Name must be between 2 and 50 characters'),
    (0, express_validator_1.body)('rank_id')
        .optional()
        .isString()
        .withMessage('Rank must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Rank must not be empty'),
    (0, express_validator_1.body)('department')
        .optional()
        .isString()
        .withMessage('Department must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Department must not be empty'),
    (0, express_validator_1.body)('active')
        .optional()
        .isBoolean()
        .withMessage('Active must be a boolean value'),
    (0, express_validator_1.body)('username')
        .optional()
        .isString()
        .withMessage('Username must be a string')
        .trim()
        .isLength({ min: 3, max: 20 })
        .withMessage('Username must be between 3 and 20 characters')
        .matches(/^[a-zA-Z0-9_]+$/)
        .withMessage('Username can only contain letters, numbers, and underscores'),
    (0, express_validator_1.body)('city')
        .optional()
        .isString()
        .withMessage('City must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('City must not be empty'),
    (0, express_validator_1.body)('phone_number')
        .optional()
        .isString()
        .withMessage('Phone number must be a string')
        .trim()
        .matches(/^\+?[0-9]{10,15}$/)
        .withMessage('Phone number must be a valid format'),
    (0, express_validator_1.body)('img_profile')
        .optional()
        .isString()
        .withMessage('Profile image must be a string'),
    (0, express_validator_1.body)('password')
        .optional()
        .isString()
        .withMessage('Password must be a string')
        .isLength({ min: 6 })
        .withMessage('Password must be at least 6 characters long'),
];
exports.loginPoliceUserValidation = [
    (0, express_validator_1.body)('username')
        .notEmpty()
        .withMessage('Username is required')
        .isString()
        .withMessage('Username must be a string')
        .trim()
        .isLength({ min: 3, max: 20 })
        .withMessage('Username must be between 3 and 20 characters')
        .matches(/^[a-zA-Z0-9_]+$/)
        .withMessage('Username can only contain letters, numbers, and underscores'),
    (0, express_validator_1.body)('phone_number')
        .notEmpty()
        .withMessage('Phone number is required')
        .isString()
        .withMessage('Phone number must be a string')
        .trim(),
    (0, express_validator_1.body)('password')
        .notEmpty()
        .withMessage('Password is required')
        .isString()
        .withMessage('Password must be a string')
        .isLength({ min: 4 })
        .withMessage('Password must be at least 4 characters long'),
];
exports.generateOTPForLogin = [
    (0, express_validator_1.body)('phone_number')
        .notEmpty()
        .withMessage('Phone number is required')
        .isString()
        .withMessage('Phone number must be a string')
        .trim(),
];
exports.changePasswordForPoliceUserValidation = [
    (0, express_validator_1.body)('password')
        .notEmpty()
        .withMessage('Password is required')
        .isString()
        .withMessage('Password must be a string')
        .isLength({ min: 4 })
        .withMessage('Password must be at least 4 characters long'),
    (0, express_validator_1.body)('re-password')
        .notEmpty()
        .withMessage('Re-password is required')
        .isString()
        .withMessage('Re-password must be a string')
        .isLength({ min: 4 })
        .withMessage('Re-password must be at least 4 characters long')
        .custom((value, { req }) => {
        if (value !== req.body.password) {
            throw new Error('Passwords do not match');
        }
        return true;
    }),
    (0, express_validator_1.body)('sms_otp')
        .notEmpty()
        .withMessage('SMS OTP is required')
        .isString()
        .withMessage('SMS OTP must be a string')
        .trim()
        .isLength({ min: 4, max: 4 })
        .withMessage('SMS OTP must be exactly 4 characters long'),
];
