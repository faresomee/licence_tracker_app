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
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getActivites = exports.getUrgentTasks = exports.getMyStatistics = exports.getMyNotification = exports.getMyDetails = exports.logoutPoliceUser = exports.generateOTPRequest = exports.changePasswordForPoliceUser = exports.generateOTPRequestForPassword = exports.loginPoliceUser = void 0;
const orm_util_1 = require("../utils/orm.util");
const police_user_access_1 = require("../auth/police_user.access");
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const bcrypt_1 = __importDefault(require("bcrypt"));
const otp_1 = require("../utils/otp");
const dateFormat_util_1 = require("../utils/dateFormat.util");
const response_1 = require("../utils/response");
exports.loginPoliceUser = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { username, password, phone_number, sms_otp } = req.body;
        const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM police_users WHERE username = ?', [username]);
        if (!result.success || !result.data || result.data.length === 0) {
            res.status(401).json({ message: 'Invalid username or password' });
            return;
        }
        const policeUser = result.data[0];
        const isPasswordValid = yield bcrypt_1.default.compare(password, policeUser.password_hash);
        if (!isPasswordValid) {
            res.status(401).json({ message: 'Invalid username or password' });
            return;
        }
        if (policeUser.phone_number !== phone_number) {
            res.status(401).json({ message: 'Invalid phone number' });
            return;
        }
        const otp = yield (0, otp_1.getOTP)(policeUser.id, 'login');
        if (otp === null) {
            res.status(401).json({
                message: 'يجب عليك إنشاء رمز تحقق (OTP) أولاً قبل تسجيل الدخول.',
            });
            return;
        }
        if (sms_otp !== otp) {
            res
                .status(401)
                .json({ message: 'رمز التحقق غير صحيح. يرجى المحاولة مرة أخرى.' });
            return;
        }
        const token = (0, police_user_access_1.generatePoliceUserJWTToken)(policeUser, req);
        yield (0, orm_util_1.executeNonQuery)('UPDATE police_users SET last_login = ? WHERE id = ?', [new Date(), policeUser.id]);
        const query = 'UPDATE police_users SET online = 1 WHERE id = ?';
        yield (0, orm_util_1.executeNonQuery)(query, [policeUser.id]);
        yield (0, orm_util_1.executeNonQuery)('DELETE FROM sms_otp WHERE police_id = ?', [
            policeUser.id,
        ]);
        // sendOTP(policeUser.phone_number, policeUser.id)
        res.status(200).json({
            message: 'Police user logged in successfully',
            token,
            user: policeUser,
        });
    }
    catch (error) {
        console.error('Login error:', error);
        res.status(500).json({ message: 'Internal server error' });
    }
}));
exports.generateOTPRequestForPassword = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user;
    yield (0, otp_1.sendOTP)(user.phone_number, user.id, 'password');
    const otp = yield (0, otp_1.getOTP)(user.id, 'password');
    res.status(200).json({
        message: 'OTP sent successfully for password reset',
        sms_otp: otp,
    });
}));
exports.changePasswordForPoliceUser = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user;
    const opt = req.body.sms_otp;
    const getOtpFromDB = yield (0, otp_1.getOTP)(user.id, 'password');
    console.log('getOtpFromDB', getOtpFromDB);
    if (getOtpFromDB === null) {
        res.status(401).json({
            message: 'يجب عليك إنشاء رمز تحقق (OTP) أولاً قبل تغيير كلمة المرور.',
        });
        return;
    }
    if (opt !== getOtpFromDB) {
        res.status(401).json({
            message: 'رمز التحقق غير صحيح. يرجى المحاولة مرة أخرى.',
        });
        return;
    }
    const { password } = req.body;
    const hashedPassword = yield bcrypt_1.default.hash(password, parseInt(process.env.SALT_PASSWORD || '10'));
    const query = 'UPDATE police_users SET password_hash = ? WHERE id = ?';
    const result = yield (0, orm_util_1.executeNonQuery)(query, [
        hashedPassword,
        req.user.id,
    ]);
    yield (0, orm_util_1.executeNonQuery)('DELETE FROM sms_otp WHERE police_id = ? AND type = ?', [req.user.id, 'password']);
    yield (0, orm_util_1.executeNonQuery)('INSERT INTO notification_police (type,police_id) VALUES (?,?)', ['password change', user.id]);
    res.status(200).json({
        message: 'تم تغيير كلمة المرور بنجاح',
        success: true,
    });
}));
exports.generateOTPRequest = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { phone_number } = req.body;
        const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM police_users WHERE phone_number = ?', [phone_number]);
        if (!result.success || !result.data || result.data.length === 0) {
            res.status(401).json({ message: 'Invalid phone number' });
            return;
        }
        const policeUser = result.data[0];
        yield (0, otp_1.sendOTP)(policeUser.phone_number, policeUser.id, 'login');
        const otp = yield (0, otp_1.getOTP)(policeUser.id, 'login');
        res.status(200).json({
            message: 'OTP sent successfully',
            sms_otp: otp,
        });
    }
    catch (error) {
        console.error('Login error:', error);
        res.status(500).json({ message: 'Internal server error' });
    }
}));
exports.logoutPoliceUser = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const user = req.user;
        const query = 'UPDATE police_users SET online = 0 WHERE id = ?';
        yield (0, orm_util_1.executeNonQuery)(query, [user.id]);
        res.status(200).json({
            message: `Police User logged out successfully`,
        });
    }
    catch (error) {
        console.error('Logout error:', error);
        res.status(500).json({ message: 'Internal server error' });
    }
}));
exports.getMyDetails = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user;
    const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM police_users WHERE id = ?', [user.id]);
    if (result.success && result.data && result.data.length > 0) {
        const userData = result.data[0];
        const { password_hash } = userData, safeUserData = __rest(userData, ["password_hash"]);
        res.status(200).json({
            success: true,
            data: safeUserData,
        });
    }
    else {
        res.status(404).json({
            success: false,
            message: 'User not found',
        });
    }
}));
exports.getMyNotification = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const user = req.user;
    const query = 'SELECT id , type , created_at FROM notification_police WHERE police_id = ? ORDER BY created_at ASC';
    const result = yield (0, orm_util_1.executeQuery)(query, [user.id]);
    const userData = (_a = result.data) === null || _a === void 0 ? void 0 : _a.map((notification) => {
        return Object.assign(Object.assign({}, notification), { created_at: (0, dateFormat_util_1.formatDateV2)(notification.created_at), description: (0, response_1.generateDescriptionForNotification)(notification.type) });
    });
    res.status(200).json({
        sucess: true,
        data: userData,
    });
}));
exports.getMyStatistics = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m;
    const user = req.user;
    const totalWantedVehcileQuery = "SELECT COUNT(*) AS 'total_wanted_veh' FROM wanted_vehicle WHERE DATE(created_at) = CURRENT_DATE;";
    const totalReportsQuery = "SELECT COUNT(*) AS 'total_reports' FROM police_reports WHERE police_id = ? AND DATE(created_at) = CURRENT_DATE;";
    const totalTicketsQuery = "SELECT COUNT(*) AS 'total_ticket' FROM violations WHERE police_id = ? AND DATE(create_at) = CURRENT_DATE;";
    const totalInspectedQuery = "SELECT COUNT(*) AS 'total_inspected' FROM inspected_vehicles WHERE police_id = ? AND DATE(create_at) = CURRENT_DATE;";
    const totalVehcile = yield (0, orm_util_1.executeQuery)(totalWantedVehcileQuery, []);
    const totalReports = yield (0, orm_util_1.executeQuery)(totalReportsQuery, [user.id]);
    const totalTickets = yield (0, orm_util_1.executeQuery)(totalTicketsQuery, [user.id]);
    const totalInspected = yield (0, orm_util_1.executeQuery)(totalInspectedQuery, [user.id]);
    res.status(200).json({
        totalVehcile: (_c = (_b = (_a = totalVehcile.data) === null || _a === void 0 ? void 0 : _a[0]) === null || _b === void 0 ? void 0 : _b.total_wanted_veh) !== null && _c !== void 0 ? _c : 0,
        totalReports: (_f = (_e = (_d = totalReports.data) === null || _d === void 0 ? void 0 : _d[0]) === null || _e === void 0 ? void 0 : _e.total_reports) !== null && _f !== void 0 ? _f : 0,
        totalTickets: (_j = (_h = (_g = totalTickets.data) === null || _g === void 0 ? void 0 : _g[0]) === null || _h === void 0 ? void 0 : _h.total_ticket) !== null && _j !== void 0 ? _j : 0,
        totalInspected: (_m = (_l = (_k = totalInspected.data) === null || _k === void 0 ? void 0 : _k[0]) === null || _l === void 0 ? void 0 : _l.total_inspected) !== null && _m !== void 0 ? _m : 0,
    });
}));
exports.getUrgentTasks = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const wantedvehicleQuery = 'SELECT vh.*,wh.description, wh.created_at FROM wanted_vehicle AS wh JOIN vehicle AS vh ON wh.plate = vh.plate ORDER BY wh.created_at ASC LIMIT 1;';
    const wantedPersonsQuery = 'SELECT p.national_id , p.criminal_status , p.changed FROM person p WHERE p.criminal_status = 1 ORDER BY changed ASC LIMIT 1;';
    const wntedVehicle = yield (0, orm_util_1.executeQuery)(wantedvehicleQuery, []);
    const wantedPerson = yield (0, orm_util_1.executeQuery)(wantedPersonsQuery, []);
    const data = (0, response_1.generateUrgentCard)(wntedVehicle.data, wantedPerson.data);
    res.status(200).json({ data });
}));
exports.getActivites = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user;
    const getTicketQuery = `SELECT
    vt.name AS "violation_type",
    v.description,
    va.name as "violation_action",
    v.created_at,
    veh.name AS "vehicle_name",
    veh.brand,
    veh.type,
    veh.plate
FROM
    violations v
JOIN violation_type vt ON
    vt.ID = v.type
INNER JOIN violation_action va ON
    va.id = v.action
RIGHT OUTER JOIN vehicle veh ON
    veh.plate = v.plate_id
    WHERE police_id = ? LIMIT 1;`;
    const cehckQuery = `SELECT veh.plate , veh.brand , veh.type , veh.name , iv.create_at FROM inspected_vehicles iv JOIN vehicle veh ON veh.plate = iv.plate WHERE police_id = ? AND DATE(create_at) = CURRENT_DATE LIMIT 1;`;
    const ticketResult = yield (0, orm_util_1.executeQuery)(getTicketQuery, [user.id]);
    const cehckResult = yield (0, orm_util_1.executeQuery)(cehckQuery, [user.id]);
    let wantedVehicle;
    if (cehckResult.data &&
        cehckResult.data.length > 0 &&
        cehckResult.data[0].plate) {
        wantedVehicle = yield (0, orm_util_1.executeQuery)('SELECT wh.plate,wh.description,wh.created_at FROM inspected_vehicles iv JOIN wanted_vehicle wh ON wh.plate = iv.plate WHERE wh.plate = ? ORDER BY created_at ASC LIMIT 1;', [cehckResult.data[0].plate]);
    }
    const data = (0, response_1.generateActivitesCard)(ticketResult.data, cehckResult.data, wantedVehicle ? wantedVehicle.data : undefined);
    res.status(200).json({
        data,
    });
}));
