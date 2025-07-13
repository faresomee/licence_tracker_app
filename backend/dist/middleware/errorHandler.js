"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.errorHandler = exports.ForbiddenError = exports.UnauthorizedError = exports.NotFoundError = exports.ValidationError = void 0;
const logger_1 = __importDefault(require("../utils/logger"));
class ValidationError extends Error {
    constructor(message, statusCode = 400) {
        super(message);
        this.statusCode = statusCode;
        this.name = 'ValidationError';
    }
}
exports.ValidationError = ValidationError;
class NotFoundError extends Error {
    constructor(message) {
        super(message);
        this.name = 'NotFoundError';
    }
}
exports.NotFoundError = NotFoundError;
class UnauthorizedError extends Error {
    constructor(message) {
        super(message);
        this.name = 'UnauthorizedError';
    }
}
exports.UnauthorizedError = UnauthorizedError;
class ForbiddenError extends Error {
    constructor(message) {
        super(message);
        this.name = 'ForbiddenError';
    }
}
exports.ForbiddenError = ForbiddenError;
const errorHandler = (err, req, res, next) => {
    var _a;
    const errorMeta = {
        path: req.path,
        method: req.method,
        ip: req.ip,
        errorName: err.name,
        stack: err.stack,
        userId: ((_a = req.user) === null || _a === void 0 ? void 0 : _a.id) || null,
        requestBody: req.body,
        requestQuery: req.query,
        requestParams: req.params,
    };
    if (err instanceof ValidationError) {
        logger_1.default.http('Validation Error', Object.assign(Object.assign({}, errorMeta), { statusCode: err.statusCode, errorType: 'ValidationError' }));
        res.status(err.statusCode).json({
            error: {
                name: err.name,
                message: err.message,
                statusCode: err.statusCode,
            },
        });
        return;
    }
    if (err instanceof NotFoundError) {
        logger_1.default.http('Not Found Error', Object.assign(Object.assign({}, errorMeta), { statusCode: 404, errorType: 'NotFoundError' }));
        res.status(404).json({
            error: {
                name: err.name,
                message: err.message,
                statusCode: 404,
            },
        });
        return;
    }
    if (err instanceof UnauthorizedError) {
        logger_1.default.http('Unauthorized Error', Object.assign(Object.assign({}, errorMeta), { statusCode: 401, errorType: 'UnauthorizedError' }));
        res.status(401).json({
            error: {
                name: err.name,
                message: err.message,
                statusCode: 401,
            },
        });
        return;
    }
    if (err instanceof ForbiddenError) {
        logger_1.default.http('Forbidden Error', Object.assign(Object.assign({}, errorMeta), { statusCode: 403, errorType: 'ForbiddenError' }));
        res.status(403).json({
            error: {
                name: err.name,
                message: err.message,
                statusCode: 403,
            },
        });
        return;
    }
    // For unexpected errors
    logger_1.default.http('Internal Server Error', Object.assign(Object.assign({}, errorMeta), { statusCode: 500, errorType: 'InternalServerError' }));
    res.status(500).json({
        error: {
            name: 'InternalServerError',
            message: 'An unexpected error occurred',
            statusCode: 500,
        },
    });
};
exports.errorHandler = errorHandler;
