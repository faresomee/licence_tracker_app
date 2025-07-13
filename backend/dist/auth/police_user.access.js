"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.generatePoliceUserJWTToken = exports.validatePoliceToken = exports.validateJWTToken = exports.extractJWTToken = void 0;
exports.isPoliceUserExist = isPoliceUserExist;
const orm_util_1 = require("../utils/orm.util");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const errorHandler_1 = require("../middleware/errorHandler");
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';
function isPoliceUserExist(username) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM police_users WHERE username = ?', [username]);
            return result.success && result.data && result.data.length > 0
                ? result.data[0]
                : false;
        }
        catch (error) {
            console.error('Error checking user existence:', error);
            return false;
        }
    });
}
const extractJWTToken = (req) => {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
        throw new errorHandler_1.UnauthorizedError('Authorization header is missing. Please provide a valid token.');
    }
    const [bearer, token] = authHeader.split(' ');
    if (bearer !== 'Bearer' || !token) {
        throw new errorHandler_1.UnauthorizedError('Invalid authorization header format. Expected format: Bearer <token>');
    }
    return token;
};
exports.extractJWTToken = extractJWTToken;
const validateJWTToken = (token) => {
    try {
        return jsonwebtoken_1.default.verify(token, JWT_SECRET);
    }
    catch (error) {
        if (error instanceof jsonwebtoken_1.default.TokenExpiredError) {
            throw new errorHandler_1.UnauthorizedError('Token has expired. Please login again.');
        }
        if (error instanceof jsonwebtoken_1.default.JsonWebTokenError) {
            throw new errorHandler_1.UnauthorizedError('Invalid token. Please provide a valid authentication token.');
        }
        throw new errorHandler_1.UnauthorizedError('Failed to verify token. Please try again.');
    }
};
exports.validateJWTToken = validateJWTToken;
const validatePoliceToken = (req, res, next) => {
    try {
        const token = (0, exports.extractJWTToken)(req);
        if (!token) {
            return next(new errorHandler_1.UnauthorizedError('No token provided'));
        }
        const decoded = (0, exports.validateJWTToken)(token);
        if (!decoded) {
            return next(new errorHandler_1.UnauthorizedError('Invalid token'));
        }
        ;
        req.user = decoded;
        next();
    }
    catch (error) {
        next(error);
    }
};
exports.validatePoliceToken = validatePoliceToken;
const generatePoliceUserJWTToken = (policeUser, req) => {
    const tokenData = {
        id: policeUser.id,
        img_profile: req.protocol +
            '://' +
            req.get('host') +
            '/uploads/images/police_users/' +
            policeUser.img_profile,
        username: policeUser.username,
        name: policeUser.name,
        rank: policeUser.rank,
        department: policeUser.department,
        city: policeUser.city,
    };
    return jsonwebtoken_1.default.sign(tokenData, JWT_SECRET, { expiresIn: '10h' });
};
exports.generatePoliceUserJWTToken = generatePoliceUserJWTToken;
