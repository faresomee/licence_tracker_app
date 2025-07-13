"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateWantedVehicle = void 0;
const express_validator_1 = require("express-validator");
exports.validateWantedVehicle = [
    (0, express_validator_1.body)('plate')
        .trim()
        .notEmpty()
        .withMessage('Plate is required')
        .isLength({ min: 3 })
        .withMessage('Plate must be at least 3 characters'),
    (0, express_validator_1.body)('location').trim().notEmpty().withMessage('Location is required'),
    (0, express_validator_1.body)('description').trim().notEmpty().withMessage('Description is required'),
];
