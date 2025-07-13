"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateUserJWTToken = exports.validateUserToken = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const police_user_access_1 = require("./police_user.access");
const errorHandler_1 = require("../middleware/errorHandler");
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';
const validateUserToken = (req, res, next) => {
    try {
        const token = (0, police_user_access_1.extractJWTToken)(req);
        if (!token) {
            return next(new errorHandler_1.UnauthorizedError('No token provided'));
        }
        const decoded = (0, police_user_access_1.validateJWTToken)(token);
        if (!decoded) {
            return next(new errorHandler_1.UnauthorizedError('Invalid token'));
        }
        ;
        req.user_data = decoded;
        next();
    }
    catch (error) {
        next(error);
    }
};
exports.validateUserToken = validateUserToken;
const generateUserJWTToken = (user) => {
    const tokenData = {
        id: user.national_id,
    };
    return jsonwebtoken_1.default.sign(tokenData, JWT_SECRET, { expiresIn: '10h' });
};
exports.generateUserJWTToken = generateUserJWTToken;
