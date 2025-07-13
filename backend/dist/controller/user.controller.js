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
exports.generateObjection = exports.getReport = exports.createReport = exports.searchVehcile = exports.login = exports.register = void 0;
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const orm_util_1 = require("../utils/orm.util");
const bcrypt_1 = __importDefault(require("bcrypt"));
const user_access_1 = require("../auth/user.access");
const multer_middleware_1 = require("../middleware/multer.middleware");
const response_1 = require("../utils/response");
exports.register = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    const { national_id, email, password } = req.body;
    const fetchIsUserExisits = yield (0, orm_util_1.executeQuery)('SELECT * FROM user_accounts WHERE national_id = ? OR email = ?', [national_id, email]);
    const fetchNationalIdData = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM person where national_id = ?', [national_id]);
    const isUserExists = (_a = fetchIsUserExisits.data) === null || _a === void 0 ? void 0 : _a.length;
    const isNationalIdExsits = (_b = fetchNationalIdData.data) === null || _b === void 0 ? void 0 : _b.length;
    if (isUserExists === 1) {
        res.status(409).json({
            sucess: false,
            message: 'A user with the provided credentials already exists. Please use a different national ID or email, or proceed to login if you already have an account.',
        });
        return;
    }
    if (!isNationalIdExsits) {
        res.status(404).json({
            sucess: false,
            message: 'No user found with the provided national ID. Please verify the number and try again.',
        });
        return;
    }
    const hash_password = yield bcrypt_1.default.hash(password, parseInt(process.env.SALT_PASSWORD || '10'));
    const result = yield (0, orm_util_1.executeNonQuery)('INSERT INTO user_accounts (national_id , email,password) VALUES (?,?,?)', [national_id, email, hash_password]);
    if (result.success) {
        res.status(201).json({
            sucess: true,
            message: 'User account has been successfully created.',
        });
    }
}));
exports.login = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const { email, password } = req.body;
    const userData = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM user_accounts WHERE email = ?', [email]);
    if (((_a = userData.data) === null || _a === void 0 ? void 0 : _a.length) === 0) {
        res.status(401).json({
            sucess: false,
            message: 'Invalid email or password. Please check your credentials and try again.',
        });
        return;
    }
    const user_password = userData.data
        ? userData.data[0].password
        : new Error('Somthing Happend');
    const correct_password = yield bcrypt_1.default.compare(password, user_password);
    if (!correct_password) {
        res.status(401).json({
            sucess: false,
            message: 'Invalid email or password. Please check your credentials and try again.',
        });
        return;
    }
    if (userData && userData.data) {
        const user = userData.data;
        const token = (0, user_access_1.generateUserJWTToken)(user[0]);
        res.status(200).json({
            sucess: true,
            token,
        });
    }
}));
exports.searchVehcile = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    if (!id) {
        res.status(400).json({
            error: "Missing required parameter: 'id'. Please include a valid ID in the request URL.",
        });
        return;
    }
    // const data = await executeSingleQuery<VehicleResponse>(
    //   `SELECT
    //      v.*,
    //      EXISTS (
    //        SELECT 1
    //        FROM wanted_vehicle w
    //        WHERE w.plate = v.plate
    //      ) AS is_wanted,
    //      (
    //        SELECT JSON_ARRAYAGG(
    //          JSON_OBJECT(
    //            'id', vio.id,
    //            'location', vio.location,
    //            'type', vio.type,
    //            'status', vio.status,
    //            'action', vio.action,
    //            'description', vio.description,
    //            'created_at', vio.created_at
    //          )
    //        )
    //        FROM violations vio
    //        WHERE vio.plate_id = v.plate
    //      ) AS violations
    //    FROM vehicle v
    //    WHERE v.plate = ?`,
    //   [id]
    // );
    const result = yield (0, orm_util_1.executeSingleQuery)(`
SELECT 
  v.plate,
  CASE 
    WHEN wv.plate IS NOT NULL THEN TRUE 
    ELSE FALSE 
  END AS is_wanted,
  IF(COUNT(vio.id) > 0,
    JSON_ARRAYAGG(
      JSON_OBJECT(
        'violation_id', vio.id,
        'location', IFNULL(vio.location, ''),
        'description', IFNULL(vio.description, ''),
        'status', IFNULL(vio.status, ''),
        'type_name', IFNULL(vt.name, '')
      )
    ),
    JSON_ARRAY()
  ) AS violations
FROM vehicle v
LEFT JOIN wanted_vehicle wv ON v.plate = wv.plate
LEFT JOIN violations vio ON v.plate = vio.plate_id
LEFT JOIN violation_type vt ON vio.type = vt.ID
WHERE v.plate = ?
GROUP BY v.plate, is_wanted;
`, [id]);
    res.json(result);
}));
exports.createReport = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user_data;
    let attachmentPaths = [];
    if (req.files && Array.isArray(req.files) && req.files.length > 0) {
        const savedFiles = yield (0, multer_middleware_1.saveUploadedFiles)(req);
        attachmentPaths = savedFiles.map((filename) => `${filename}`);
        const query = `
            INSERT INTO user_report 
            (name, phone, national_id, address, date, vehcile_types, description , attachment )
            VALUES (?, ?, ?, ?, ?, ?,?,?)
          `;
        const values = [
            req.body.name,
            req.body.phone,
            user.id,
            req.body.address,
            req.body.date,
            req.body.vehcile_types,
            req.body.description,
            JSON.stringify(attachmentPaths),
        ];
        yield (0, orm_util_1.executeQuery)(query, values);
    }
    else {
        res.status(401).json({
            message: 'images not found',
        });
        return;
    }
    res.status(201).json({ success: true, message: 'Report created' });
}));
exports.getReport = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const { id } = req.params;
    const user = req.user_data;
    if (!id) {
        res.status(400).json({ message: 'Report ID is required in URL params.' });
        return;
    }
    const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM user_report WHERE id = ? AND national_id = ?', [id, user.id]);
    const data = (_a = result.data) === null || _a === void 0 ? void 0 : _a.map((row) => (Object.assign(Object.assign({}, row), { attachment: row.attachment
            ? (0, response_1.HandelAttachmets)(row.attachment, req.protocol, req.get('host'), 'user_report')
            : undefined })));
    if (result && result.data) {
        res.status(200).json(data);
    }
    else {
        res.status(200).json({});
    }
}));
exports.generateObjection = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { report_id, description } = req.body;
    const user = req.user_data;
    const data = yield (0, orm_util_1.executeSingleQuery)("SELECT COUNT(*) as total FROM user_objections WHERE id = ? AND national_id = ? AND status = 'pending'  ", [report_id, user.id]);
    const userdata = yield (0, orm_util_1.executeSingleQuery)('SELECT COUNT(*) as total FROM user_report WHERE id = ? AND status = "rejected" ', [report_id]);
    if (userdata && userdata.data) {
        if (userdata.data[0].total === 0) {
            res
                .status(404)
                .json({
                message: 'No objection found for the provided ID, or your report has not been reviewed yet.',
            });
            return;
        }
    }
    if (data && data.data) {
        if (data.data[0].total > 0) {
            res.status(401).json({
                message: 'You have exceeded the maximum number of allowed objections.',
            });
            return;
        }
    }
    const result = yield (0, orm_util_1.executeNonQuery)('INSERT INTO user_objections (report_id ,national_id,description, status) VALUES (?,?,?,?)', [report_id, user.id, description, 'pending']);
    res.json({ message: 'objection created' });
}));
