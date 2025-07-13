"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateCreateVehicleBody = void 0;
const errorHandler_1 = require("./errorHandler");
const validateCreateVehicleBody = (req, res, next) => {
    try {
        const { Manufacturer, model, color, year } = req.body;
        if (!Manufacturer || !model || !color || !year) {
            throw new errorHandler_1.ValidationError('Missing required fields: Manufacturer, model, color, year');
        }
        if (typeof Manufacturer !== 'string' || Manufacturer.trim().length < 2) {
            throw new errorHandler_1.ValidationError('Manufacturer must be at least 2 characters long');
        }
        if (typeof model !== 'string' || model.trim().length < 1) {
            throw new errorHandler_1.ValidationError('Model must be at least 1 character long');
        }
        if (typeof color !== 'string' || color.trim().length < 2) {
            throw new errorHandler_1.ValidationError('Color must be at least 2 characters long');
        }
        if (typeof year !== 'number' ||
            year < 1900 ||
            year > new Date().getFullYear() + 1) {
            throw new errorHandler_1.ValidationError('Year must be a valid number between 1900 and next year');
        }
        next();
    }
    catch (error) {
        next(error);
    }
};
exports.validateCreateVehicleBody = validateCreateVehicleBody;
