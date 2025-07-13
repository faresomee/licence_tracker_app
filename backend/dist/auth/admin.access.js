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
exports.validateAdminJWTToken = exports.extractAdminJWTToken = void 0;
exports.isAdminExist = isAdminExist;
exports.checkAdminPrivilege = checkAdminPrivilege;
exports.isSuperAdmin = isSuperAdmin;
exports.isAdmin = isAdmin;
exports.generateAdminJWTToken = generateAdminJWTToken;
const orm_util_1 = require("../utils/orm.util");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const dotenv_1 = __importDefault(require("dotenv"));
const errorHandler_1 = require("../middleware/errorHandler");
dotenv_1.default.config();
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';
function isAdminExist(email) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM admin_users WHERE email = ?', [email]);
            return result.success && result.data && result.data.length > 0
                ? result.data[0]
                : false;
        }
        catch (error) {
            console.error('Error checking admin existence:', error);
            return false;
        }
    });
}
const extractAdminJWTToken = (req) => {
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
exports.extractAdminJWTToken = extractAdminJWTToken;
const validateAdminJWTToken = (token) => {
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
exports.validateAdminJWTToken = validateAdminJWTToken;
function checkAdminPrivilege(adminId, requiredRole) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const result = yield (0, orm_util_1.executeSingleQuery)('SELECT role FROM admin_users WHERE id = ?', [adminId]);
            if (!result.success || !result.data || result.data.length === 0)
                return false;
            const adminRole = result.data[0].role;
            return adminRole === requiredRole;
        }
        catch (error) {
            console.error('Error checking admin privilege:', error);
            return false;
        }
    });
}
function isSuperAdmin(adminId) {
    return __awaiter(this, void 0, void 0, function* () {
        return checkAdminPrivilege(adminId, 'superadmin');
    });
}
function isAdmin(adminId) {
    return __awaiter(this, void 0, void 0, function* () {
        return checkAdminPrivilege(adminId, 'admin');
    });
}
function generateAdminJWTToken(admin, req) {
    return jsonwebtoken_1.default.sign({
        id: admin.id,
        email: admin.email,
        role: admin.role,
        name: admin.name,
        img_profile: req.protocol +
            '://' +
            req.get('host') +
            '/uploads/images/admin_users/' +
            admin.img_profile,
    }, JWT_SECRET, { expiresIn: '24h' });
}
