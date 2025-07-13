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
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateAdminId = exports.validateAdminToken = void 0;
const police_user_access_1 = require("../auth/police_user.access");
const admin_access_1 = require("../auth/admin.access");
const errorHandler_1 = require("./errorHandler");
const validateAdminToken = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const token = (0, police_user_access_1.extractJWTToken)(req);
        if (!token) {
            throw new errorHandler_1.UnauthorizedError('No token provided');
        }
        const decoded = (0, police_user_access_1.validateJWTToken)(token);
        if (!decoded || !decoded.id) {
            throw new errorHandler_1.UnauthorizedError('Invalid token format');
        }
        const isUserAdmin = yield (0, admin_access_1.isAdmin)(decoded.id);
        const isUserSuperAdmin = yield (0, admin_access_1.isSuperAdmin)(decoded.id);
        if (!isUserAdmin && !isUserSuperAdmin) {
            throw new errorHandler_1.ForbiddenError('Access denied. Admin privileges required.');
        }
        res.locals.user = decoded;
        next();
    }
    catch (error) {
        next(error);
    }
});
exports.validateAdminToken = validateAdminToken;
const validateAdminId = (req, res, next) => {
    try {
        const { id } = req.params;
        const adminId = parseInt(id);
        if (isNaN(adminId) || adminId <= 0) {
            throw new errorHandler_1.ValidationError('Invalid admin ID format');
        }
        req.params.id = adminId.toString();
        next();
    }
    catch (error) {
        next(error);
    }
};
exports.validateAdminId = validateAdminId;
