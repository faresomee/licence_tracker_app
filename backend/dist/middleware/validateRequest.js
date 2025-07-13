"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateRequest = void 0;
const errorHandler_1 = require("./errorHandler");
const express_validator_1 = require("express-validator");
const validateRequest = (req, res, next) => {
    const errors = (0, express_validator_1.validationResult)(req);
    if (!errors.isEmpty()) {
        const errorMessages = errors.array().map((error) => error.msg);
        throw new errorHandler_1.ValidationError(errorMessages.join(', '));
    }
    next();
};
exports.validateRequest = validateRequest;
