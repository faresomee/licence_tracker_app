"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.policeTicketValidation = void 0;
const express_validator_1 = require("express-validator");
exports.policeTicketValidation = [
    (0, express_validator_1.body)('vehicle_plate')
        .notEmpty()
        .withMessage('Vehicle plate is required')
        .isString()
        .withMessage('Vehicle plate must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Vehicle plate must not be empty'),
    (0, express_validator_1.body)('location')
        .notEmpty()
        .withMessage('Location is required')
        .isString()
        .withMessage('Location must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Location must not be empty'),
    (0, express_validator_1.body)('violation_type')
        .notEmpty()
        .withMessage('Violation type is required')
        .isInt()
        .withMessage('Violation type must be an integer')
        .isIn([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        .withMessage('Violation type must be between 1 and 10'),
    (0, express_validator_1.body)('action_taken')
        .notEmpty()
        .withMessage('Action taken is required')
        .isInt()
        .withMessage('Action taken must be an integer')
        .isIn([1, 2, 3, 4, 5, 6, 7])
        .withMessage('Action taken must be between 1 and 7'),
    (0, express_validator_1.body)('description')
        .notEmpty()
        .withMessage('Description is required')
        .isString()
        .withMessage('Description must be a string')
        .trim()
        .isLength({ min: 1 })
        .withMessage('Description must not be empty'),
    (0, express_validator_1.body)('attachment')
        .optional()
        .isString()
        .withMessage('Attachment must be a string'),
    (0, express_validator_1.body)('status')
        .optional()
        .isString()
        .withMessage('Status must be a string')
        .isIn(['paied', 'unpaied', ''])
        .withMessage("Status must be either 'paied', 'unpaied', or ''"),
];
