"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createReportTypeValidation = exports.createReportValidation = void 0;
const express_validator_1 = require("express-validator");
exports.createReportValidation = [
    (0, express_validator_1.body)('title')
        .notEmpty()
        .withMessage('Title of reprots is required')
        .trim()
        .isString()
        .withMessage('Title of reports must be a string')
        .isLength({ min: 5, max: 50 })
        .withMessage('Title of reports must be between 5 and 50 characters'),
    (0, express_validator_1.body)('type')
        .notEmpty()
        .withMessage('Type of reprots is required')
        .isInt()
        .withMessage('Type of reports must be an integer'),
    (0, express_validator_1.body)('description')
        .notEmpty()
        .withMessage('Description of reprots is required')
        .trim()
        .isString()
        .withMessage('Description of reports must be a string')
        .isLength({ min: 10, max: 500 })
        .withMessage('Description of reports must be between 10 and 500 characters'),
];
exports.createReportTypeValidation = [
    (0, express_validator_1.body)('name')
        .notEmpty()
        .withMessage('Name of reprots is required')
        .trim()
        .isString()
        .withMessage('Name of reports must be a string')
        .isLength({ min: 5, max: 50 })
        .withMessage('Name of reports must be between 5 and 50 characters'),
    (0, express_validator_1.body)('point')
        .notEmpty()
        .withMessage('Point of reprots is required')
        .isInt()
        .withMessage('Point of reports must be an integer')
        .isIn([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        .withMessage('Point of reports must be between 1 and 10'),
];
