"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PersonCriminalStatusValidation = exports.PersonValidation = void 0;
const express_validator_1 = require("express-validator");
exports.PersonValidation = [
    (0, express_validator_1.param)('id')
        .notEmpty()
        .withMessage('ID is required')
        .isInt()
        .withMessage('ID must be an integer')
        .trim()
        .isLength({ min: 14, max: 14 })
        .withMessage('ID must be 14 characters long'),
];
exports.PersonCriminalStatusValidation = [
    (0, express_validator_1.body)('criminal_status')
        .notEmpty()
        .withMessage('Criminal status is required')
        .isIn(['0', '1'])
        .withMessage('Criminal status must be either 0 or 1')
        .trim(),
];
