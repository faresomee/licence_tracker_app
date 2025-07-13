"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
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
exports.changeUserObjectionStatus = exports.changeUserReportStatus = exports.getAllUsersObjections = exports.getAllUsersReports = exports.getAllUsersAccounts = exports.getAllVheciles = exports.updateViolationByAdmin = exports.deleteViolationByAdmin = exports.createViolationForAdmin = exports.getSpesificViolation = exports.getViolationsType = exports.getAllViolations = exports.deleteUser = exports.updateUser = exports.getUser = exports.getAllUsers = exports.createUser = exports.loginAdmin = exports.deleteAdmin = exports.updateAdmin = exports.getAllAdmins = exports.getAdmin = exports.createAdmin = void 0;
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const orm_util_1 = require("../utils/orm.util");
const bcrypt_1 = __importDefault(require("bcrypt"));
const admin_access_1 = require("../auth/admin.access");
const police_user_access_1 = require("../auth/police_user.access");
const path = __importStar(require("path"));
const fs = __importStar(require("fs"));
const multer_middleware_1 = require("../middleware/multer.middleware");
const response_1 = require("../utils/response");
const dateFormat_util_1 = require("../utils/dateFormat.util");
const createAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { name, email, password_hash, role } = req.body;
    const hashedPassword = yield bcrypt_1.default.hash(password_hash || '', parseInt(process.env.SALT_PASSWORD || '10'));
    let img_profile = 'default.png';
    if (req.file) {
        try {
            img_profile = yield (0, multer_middleware_1.saveUploadedFile)(req);
        }
        catch (error) {
            res.status(500).json({ error: 'Failed to save profile image' });
            return;
        }
    }
    const query = `INSERT INTO admin_users (name, img_profile, email, password_hash, role, status, created_at) 
                   VALUES (?, ?, ?, ?, ?, ?, ?)`;
    const values = [
        name,
        img_profile,
        email,
        hashedPassword,
        role || 'admin',
        'active',
        new Date(),
    ];
    const result = yield (0, orm_util_1.executeNonQuery)(query, values);
    if (result.success) {
        res.status(201).json({
            message: 'Admin created successfully',
            affectedRows: result.affectedRows,
        });
    }
    else {
        if (req.file && img_profile !== 'default.png') {
            const img_path = path.join(__dirname, '..', 'uploads', 'images', 'admin_users', img_profile);
            if (fs.existsSync(img_path)) {
                fs.unlinkSync(img_path);
            }
        }
        res.status(500).json({ error: result.error });
    }
}));
exports.createAdmin = createAdmin;
const getAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM admin_users WHERE id = ?', [id]);
    if (result.success && result.data && result.data.length > 0) {
        const admin = result.data[0];
        const response = {
            id: admin.id,
            name: admin.name,
            email: admin.email,
            role: admin.role,
            status: admin.status,
            img_profile: req.protocol +
                '://' +
                req.get('host') +
                '/uploads/images/admin_users/' +
                admin.img_profile,
            last_login: admin.last_login,
            created_at: admin.created_at,
            updated_at: admin.updated_at,
        };
        res.json(response);
    }
    else {
        res.status(404).json({ error: 'Admin not found' });
    }
}));
exports.getAdmin = getAdmin;
const getAllAdmins = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const countResult = yield (0, orm_util_1.executeSingleQuery)('SELECT COUNT(*) as total FROM admin_users');
    const result = yield (0, orm_util_1.executeQuery)(`SELECT id, name, email, role, status, img_profile, last_login, created_at, updated_at 
     FROM admin_users 
     ORDER BY created_at  
     LIMIT ? OFFSET ?`, [limit, offset]);
    if (result.success &&
        result.data &&
        countResult.success &&
        countResult.data) {
        const response = {
            data: result.data.map((admin) => ({
                id: admin.id,
                name: admin.name,
                email: admin.email,
                role: admin.role,
                status: admin.status,
                img_profile: req.protocol +
                    '://' +
                    req.get('host') +
                    '/uploads/images/admin_users/' +
                    admin.img_profile,
                last_login: admin.last_login,
                created_at: admin.created_at,
                updated_at: admin.updated_at,
            })),
            pagination: {
                total: countResult.data[0].total,
                page,
                limit,
                totalPages: Math.ceil(countResult.data[0].total / limit),
            },
        };
        res.json(response);
    }
    else {
        res.status(500).json({ error: result.error || countResult.error });
    }
}));
exports.getAllAdmins = getAllAdmins;
const updateAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const { id } = req.params;
    const { name, email, status, password, role } = req.body;
    const updates = [];
    const values = [];
    if (name !== undefined) {
        updates.push('name = ?');
        values.push(name);
    }
    if (role !== undefined) {
        updates.push('role = ?');
        values.push(role);
    }
    if (password !== undefined) {
        updates.push('password_hash = ?');
        const newPassword = bcrypt_1.default.hashSync(password, parseInt(process.env.SALT_PASSWORD || '10'));
        values.push(newPassword);
    }
    let newImgProfile;
    let oldImgProfile = null;
    if (req.file) {
        try {
            const UserData = yield (0, orm_util_1.executeSingleQuery)('SELECT img_profile FROM admin_users WHERE id = ?', [id]);
            if (UserData.success && UserData.data && UserData.data.length > 0) {
                oldImgProfile = (_a = UserData.data[0].img_profile) !== null && _a !== void 0 ? _a : null;
                newImgProfile = yield (0, multer_middleware_1.saveUploadedFile)(req);
                updates.push('img_profile = ?');
                values.push(newImgProfile);
                if (oldImgProfile && oldImgProfile !== 'default.png') {
                    const oldImgPath = path.join(__dirname, '..', 'uploads', 'images', 'admin_users', oldImgProfile);
                    if (fs.existsSync(oldImgPath)) {
                        fs.unlinkSync(oldImgPath);
                    }
                }
            }
        }
        catch (error) {
            res.status(500).json({ error: 'Failed to save profile image' });
            return;
        }
    }
    if (email !== undefined) {
        updates.push('email = ?');
        values.push(email);
    }
    if (status !== undefined) {
        updates.push('status = ?');
        values.push(status);
    }
    updates.push('updated_at = ?');
    values.push(new Date());
    if (updates.length === 1) {
        res.status(400).json({ error: 'No fields to update' });
        return;
    }
    values.push(id);
    const query = `UPDATE admin_users 
                 SET ${updates.join(', ')}
                 WHERE id = ?`;
    const result = yield (0, orm_util_1.executeNonQuery)(query, values);
    if (result.success) {
        res.json({
            message: 'Admin updated successfully',
            affectedRows: result.affectedRows,
        });
    }
    else {
        if (newImgProfile) {
            const newImgPath = path.join(__dirname, '..', 'uploads', 'images', 'admin_users', newImgProfile);
            if (fs.existsSync(newImgPath)) {
                fs.unlinkSync(newImgPath);
            }
        }
        res.status(500).json({ error: result.error });
    }
}));
exports.updateAdmin = updateAdmin;
const deleteAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const AdminData = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM admin_users WHERE id = ?', [id]);
    if (AdminData.success && AdminData.data && AdminData.data.length > 0) {
        const img_profile = AdminData.data[0].img_profile;
        if (img_profile && img_profile !== 'default.png') {
            const img_path = path.join(__dirname, '..', 'uploads', 'images', 'admin_users', img_profile);
            if (fs.existsSync(img_path)) {
                fs.unlinkSync(img_path);
            }
        }
    }
    const result = yield (0, orm_util_1.executeNonQuery)('DELETE FROM admin_users WHERE id = ?', [
        id,
    ]);
    if (result.success) {
        res.json({
            message: 'Admin deleted successfully',
            affectedRows: result.affectedRows,
        });
    }
    else {
        res.status(500).json({ error: result.error });
    }
}));
exports.deleteAdmin = deleteAdmin;
const loginAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { email, password } = req.body;
    const result = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM admin_users WHERE email = ?', [email]);
    if (!result.success || !result.data || result.data.length === 0) {
        res.status(401).json({ error: 'Invalid credentials' });
        return;
    }
    const admin = result.data[0];
    if (admin.status !== 'active') {
        res.status(403).json({ error: 'Account is not active' });
        return;
    }
    const isValidPassword = yield bcrypt_1.default.compare(password, admin.password_hash);
    if (!isValidPassword) {
        res.status(401).json({ error: 'Invalid credentials' });
        return;
    }
    yield (0, orm_util_1.executeNonQuery)('UPDATE admin_users SET last_login = ? WHERE id = ?', [
        new Date(),
        admin.id,
    ]);
    const token = (0, admin_access_1.generateAdminJWTToken)(admin, req);
    res.json({
        message: 'Login successful',
        token,
        admin: {
            id: admin.id,
            name: admin.name,
            email: admin.email,
            role: admin.role,
            status: admin.status,
        },
    });
}));
exports.loginAdmin = loginAdmin;
const createUser = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { military_id, name, rank_id, department, active, username, password, phone_number, city, } = req.body;
    const existingUser = yield (0, police_user_access_1.isPoliceUserExist)(username);
    if (existingUser) {
        res.status(400).json({ error: 'Police User already exists' });
        return;
    }
    let img_profile = null;
    if (req.file) {
        try {
            img_profile = yield (0, multer_middleware_1.saveUploadedFile)(req);
        }
        catch (error) {
            res.status(500).json({ error: 'Failed to save profile image' });
            return;
        }
    }
    const hashedPassword = yield bcrypt_1.default.hash(password, parseInt(process.env.SALT_PASSWORD || '10'));
    const query = `INSERT INTO police_users (military_id, name, \`rank_id\`, department, active, username, city, password_hash, phone_number, img_profile) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
    const result = yield (0, orm_util_1.executeNonQuery)(query, [
        military_id,
        name,
        rank_id,
        department,
        active,
        username,
        city,
        hashedPassword,
        phone_number,
        img_profile,
    ]);
    if (result.success) {
        res.status(200).json({ message: 'Police User created successfully' });
    }
    else {
        if (img_profile) {
            const img_path = path.join(__dirname, '..', 'uploads', 'images', 'police_users', img_profile);
            if (fs.existsSync(img_path)) {
                fs.unlinkSync(img_path);
            }
        }
        res.status(500).json({ error: result.error });
    }
}));
exports.createUser = createUser;
const getAllUsers = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const countResult = yield (0, orm_util_1.executeSingleQuery)('SELECT COUNT(*) as total FROM police_users');
    const result = yield (0, orm_util_1.executeQuery)(`SELECT pu.id, pu.military_id, pu.name, pu.rank_id, pu.department, pu.city, pu.active, pu.username, pu.phone_number, pu.img_profile, pu.last_login, pu.created_at, pu.online, pu.updated_at, (SELECT COUNT(*) FROM violations v WHERE v.police_id = pu.id) AS total_violations FROM police_users pu ORDER BY pu.created_at ASC LIMIT ? OFFSET ?;`, [limit, offset]);
    if (result.success &&
        result.data &&
        countResult.success &&
        countResult.data) {
        const response = {
            data: result.data.map((user) => ({
                id: user.id,
                badgeNum: user.military_id,
                name: user.name,
                rank_id: user.rank_id,
                department: user.department,
                city: user.city,
                active: user.active,
                username: user.username,
                phone_number: user.phone_number,
                total_violation: user.total_violations || 0,
                img_profile: req.protocol +
                    '://' +
                    req.get('host') +
                    '/uploads/images/police_users/' +
                    user.img_profile,
                last_login: user.last_login,
                online: user.online,
                created_at: user.created_at,
                updated_at: user.updated_at,
            })),
            pagination: {
                total: countResult.data[0].total,
                page,
                limit,
                totalPages: Math.ceil(countResult.data[0].total / limit),
            },
        };
        res.json(response);
    }
    else {
        res.status(500).json({ error: result.error || countResult.error });
    }
}));
exports.getAllUsers = getAllUsers;
const getUser = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const result = yield (0, orm_util_1.executeSingleQuery)('SELECT p.* , v.plate_id FROM police_users p LEFT JOIN violations AS v ON p.id = v.police_id WHERE p.id = ?', [id]);
    if (result.success && result.data && result.data.length > 0) {
        const user = result.data[0];
        const violation = yield (0, response_1.HandelViolations)(user);
        const response = {
            id: user.id,
            badgeNum: user.military_id,
            name: user.name,
            rank_id: user.rank_id,
            department: user.department,
            city: user.city,
            active: user.active,
            username: user.username,
            phone_number: user.phone_number,
            img_profile: req.protocol +
                '://' +
                req.get('host') +
                '/uploads/images/police_users/' +
                user.img_profile,
            last_login: user.last_login,
            online: user.online,
            created_at: user.created_at,
            updated_at: user.updated_at,
            violations: violation,
        };
        res.json(response);
    }
    else {
        res.status(404).json({ error: 'Police User not found' });
    }
}));
exports.getUser = getUser;
const deleteUser = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const UserData = yield (0, orm_util_1.executeSingleQuery)('SELECT * FROM police_users WHERE id = ?', [id]);
    if (UserData.success && UserData.data && UserData.data.length > 0) {
        const img_profile = UserData.data[0].img_profile;
        if (img_profile) {
            const img_path = path.join(__dirname, '..', 'uploads', 'images', 'police_users', img_profile);
            if (fs.existsSync(img_path)) {
                fs.unlinkSync(img_path);
            }
        }
        const result = yield (0, orm_util_1.executeNonQuery)('UPDATE police_users SET active = 0 WHERE id = ?', [id]);
        if (result.success) {
            res.json({ message: 'Police User deleted successfully' });
        }
        else {
            res.status(500).json({ error: result.error });
        }
    }
    else {
        res.status(404).json({ error: 'Police User not found' });
    }
}));
exports.deleteUser = deleteUser;
const updateUser = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const { id } = req.params;
    const { military_id, name, rank_id, department, active, username, phone_number, city, password, } = req.body;
    const updates = [];
    const values = [];
    if (military_id !== undefined) {
        updates.push('military_id = ?');
        values.push(military_id);
    }
    if (password !== undefined) {
        updates.push('password_hash = ?');
        const newPassword = bcrypt_1.default.hashSync(password, parseInt(process.env.SALT_PASSWORD || '10'));
        values.push(newPassword);
    }
    if (name !== undefined) {
        updates.push('name = ?');
        values.push(name);
    }
    if (rank_id !== undefined) {
        updates.push('rank_id = ?');
        values.push(rank_id);
    }
    if (department !== undefined) {
        updates.push('department = ?');
        values.push(department);
    }
    if (active !== undefined) {
        updates.push('active = ?');
        values.push(active);
    }
    if (username !== undefined) {
        updates.push('username = ?');
        values.push(username);
    }
    if (city !== undefined) {
        updates.push('city = ?');
        values.push(city);
    }
    if (phone_number !== undefined) {
        updates.push('phone_number = ?');
        values.push(phone_number);
    }
    let newImgProfile;
    let oldImgProfile = null;
    if (req.file) {
        try {
            const UserData = yield (0, orm_util_1.executeSingleQuery)('SELECT img_profile FROM police_users WHERE id = ?', [id]);
            if (UserData.success && UserData.data && UserData.data.length > 0) {
                oldImgProfile = (_a = UserData.data[0].img_profile) !== null && _a !== void 0 ? _a : null;
                newImgProfile = yield (0, multer_middleware_1.saveUploadedFile)(req);
                updates.push('img_profile = ?');
                values.push(newImgProfile);
                if (oldImgProfile && oldImgProfile !== 'default.png') {
                    const oldImgPath = path.join(__dirname, '..', 'uploads', 'images', 'police_users', oldImgProfile);
                    if (fs.existsSync(oldImgPath)) {
                        fs.unlinkSync(oldImgPath);
                    }
                }
            }
        }
        catch (error) {
            res.status(500).json({ error: 'Failed to save profile image' });
            return;
        }
    }
    updates.push('updated_at = ?');
    values.push(new Date());
    if (updates.length === 1) {
        res.status(400).json({ error: 'No fields to update' });
        return;
    }
    values.push(id);
    const query = `UPDATE police_users 
                 SET ${updates.join(', ')}
                 WHERE id = ?`;
    const result = yield (0, orm_util_1.executeNonQuery)(query, values);
    if (result.success) {
        res.json({
            message: 'Police User updated successfully',
            affectedRows: result.affectedRows,
        });
    }
    else {
        if (newImgProfile) {
            const newImgPath = path.join(__dirname, '..', 'uploads', 'images', 'police_users', newImgProfile);
            if (fs.existsSync(newImgPath)) {
                fs.unlinkSync(newImgPath);
            }
        }
        res.status(500).json({ error: result.error });
    }
}));
exports.updateUser = updateUser;
const getAllViolations = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const countResult = yield (0, orm_util_1.executeSingleQuery)('SELECT COUNT(*) as total FROM violations');
    const data = yield (0, orm_util_1.executeQuery)('SELECT v.id , v.plate_id , v.location , vt.name , v.status , v.attachments, v.description FROM violations v JOIN violation_type vt ON vt.ID = v.type LIMIT  ? OFFSET  ?;', [limit, offset]);
    let newData;
    if (data && data.data) {
        newData = (_a = data.data) === null || _a === void 0 ? void 0 : _a.map((violation) => {
            return Object.assign(Object.assign({}, violation), { attachments: violation.attachments
                    ? (0, response_1.HandelAttachmets)(violation.attachments, req.protocol, req.get('host'))
                    : undefined });
        });
    }
    if (countResult && countResult.data)
        res.json({
            sucess: true,
            data: newData,
            pagination: {
                total: countResult.data[0].total,
                totalPages: Math.ceil(countResult.data[0].total / limit),
                page: page,
                limit: limit,
            },
        });
}));
exports.getAllViolations = getAllViolations;
const getViolationsType = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield (0, orm_util_1.executeQuery)('SELECT * FROM violation_type');
    res.status(200).json(data.data);
}));
exports.getViolationsType = getViolationsType;
const getSpesificViolation = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const id = req.params.id;
    const result = yield (0, orm_util_1.executeQuery)(`SELECT 
      p.national_id AS vehicle_owner_id,
      v.plate AS vehicle_plate, 
      p.full_name AS vehicle_owner_name, 
      p.address AS owner_location, 
      v.brand AS vehicle_brand, 
      vio.id AS violation_id, 
      vt.name AS violation_type_name, 
      vio.created_at AS violation_date, 
      vio.location AS violation_location, 
      pu.name AS officer_name, 
      pu.id AS officer_id, 
      vio.status AS violation_status, 
      vio.attachments as attachments,
      vio.description AS violation_description 
    FROM violations vio 
    JOIN vehicle v ON vio.plate_id = v.plate 
    JOIN vehicle_license vl ON v.plate = vl.vehicle_plate 
    JOIN driver_license dl ON vl.driving_license_id = dl.number 
    JOIN person p ON dl.driver_id = p.national_id 
    JOIN violation_type vt ON vio.type = vt.ID 
    JOIN police_users pu ON vio.police_id = pu.id 
    WHERE vio.id = ?;`, [id]);
    const data = (_a = result.data) === null || _a === void 0 ? void 0 : _a.map((row) => (Object.assign(Object.assign({}, row), { violation_date: (0, dateFormat_util_1.getFullDate)(row.violation_date), attachments: row.attachments
            ? (0, response_1.HandelAttachmets)(row.attachments, req.protocol, req.get('host'))
            : undefined })));
    res.json(data ? data[0] : data);
}));
exports.getSpesificViolation = getSpesificViolation;
const createViolationForAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let attachmentPaths = [];
    if (req.files && Array.isArray(req.files) && req.files.length > 0) {
        const savedFiles = yield (0, multer_middleware_1.saveUploadedFiles)(req);
        attachmentPaths = savedFiles.map((filename) => `${filename}`);
        const query = `
          INSERT INTO violations 
          (police_id, plate_id, location, type, description, attachments , status )
          VALUES (?, ?, ?, ?, ?, ?,?)
        `;
        const values = [
            req.body.police_id,
            req.body.plate_id,
            req.body.location,
            req.body.type,
            req.body.description,
            JSON.stringify(attachmentPaths),
            'under_review',
        ];
        yield (0, orm_util_1.executeQuery)(query, values);
    }
    else {
        const query = `
              INSERT INTO violations 
              (police_id, plate_id, location, type, description , status )
              VALUES (?, ?, ?, ?, ?,?)
          `;
        const values = [
            req.body.police_id,
            req.body.plate_id,
            req.body.location,
            req.body.type,
            req.body.description,
            'under_review',
        ];
        yield (0, orm_util_1.executeQuery)(query, values);
    }
    res.status(201).json({ success: true, message: 'Ticket created' });
}));
exports.createViolationForAdmin = createViolationForAdmin;
const deleteViolationByAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    if (!id) {
        res.status(400).json({ message: 'Violation ID is required' });
        return;
    }
    const query = 'DELETE FROM violations WHERE id = ?';
    const result = yield (0, orm_util_1.executeNonQuery)(query, [id]);
    if (result.affectedRows === 0) {
        res.status(404).json({ message: 'Violation not found' });
        return;
    }
    res.status(200).json({ message: 'Violation deleted successfully' });
}));
exports.deleteViolationByAdmin = deleteViolationByAdmin;
const updateViolationByAdmin = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const id = Number(req.params.id);
    const { status } = req.body;
    if (!id || !status) {
        res.status(400).json({ message: 'Violation ID and status are required' });
        return;
    }
    if (isNaN(id)) {
        res.status(400).json({ message: 'Violation ID must be a valid number' });
        return;
    }
    const validStatuses = ['paied', 'unpaied', 'under_review'];
    if (!validStatuses.includes(status)) {
        res.status(400).json({ message: 'Invalid status value' });
        return;
    }
    const query = 'UPDATE violations SET status = ? WHERE id = ?';
    const result = yield (0, orm_util_1.executeNonQuery)(query, [status, id]);
    if (result.affectedRows === 0) {
        res
            .status(404)
            .json({ message: 'Violation not found or already has this status' });
        return;
    }
    res.status(200).json({ message: 'Violation status updated successfully' });
}));
exports.updateViolationByAdmin = updateViolationByAdmin;
const getAllVheciles = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const countQuery = `SELECT COUNT(*) AS total FROM vehicle`;
    const countResult = yield (0, orm_util_1.executeQuery)(countQuery, []);
    let total = 0;
    if (countResult && countResult.data) {
        total = countResult.data[0].total;
    }
    const dataQuery = `
    SELECT * FROM vehicle
    LIMIT ? OFFSET ?
  `;
    const data = yield (0, orm_util_1.executeQuery)(dataQuery, [limit, offset]);
    res.json({
        data: data.data,
        pagination: {
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        },
    });
}));
exports.getAllVheciles = getAllVheciles;
const getAllUsersAccounts = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        const page = parseInt(req.query.page, 10) || 1;
        const limit = parseInt(req.query.limit, 10) || 10;
        const offset = (page - 1) * limit;
        const usersResult = yield (0, orm_util_1.executeQuery)('SELECT * FROM user_accounts LIMIT ? OFFSET ?', [limit, offset]);
        const users = (usersResult === null || usersResult === void 0 ? void 0 : usersResult.data) || [];
        const sanitizedUsers = users.map((user) => {
            const { password } = user, safeUser = __rest(user, ["password"]);
            return safeUser;
        });
        const countResult = yield (0, orm_util_1.executeQuery)('SELECT COUNT(*) AS total FROM user_accounts');
        const total = ((_b = (_a = countResult === null || countResult === void 0 ? void 0 : countResult.data) === null || _a === void 0 ? void 0 : _a[0]) === null || _b === void 0 ? void 0 : _b.total) || 0;
        const totalPages = Math.ceil(total / limit);
        res.status(200).json({
            success: true,
            message: 'Users fetched successfully.',
            data: sanitizedUsers,
            pagination: { page, limit, total, totalPages },
        });
    }
    catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({
            success: false,
            message: 'An error occurred while fetching user accounts.',
        });
    }
}));
exports.getAllUsersAccounts = getAllUsersAccounts;
const getAllUsersReports = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b, _c;
    const page = parseInt(req.query.page, 10) || 1;
    const limit = parseInt(req.query.limit, 10) || 10;
    const offset = (page - 1) * limit;
    const usersResult = yield (0, orm_util_1.executeQuery)('SELECT * FROM user_report LIMIT ? OFFSET ?', [limit, offset]);
    const countResult = yield (0, orm_util_1.executeQuery)('SELECT COUNT(*) AS total FROM user_report');
    const total = ((_b = (_a = countResult === null || countResult === void 0 ? void 0 : countResult.data) === null || _a === void 0 ? void 0 : _a[0]) === null || _b === void 0 ? void 0 : _b.total) || 0;
    const totalPages = Math.ceil(total / limit);
    const data = (_c = usersResult.data) === null || _c === void 0 ? void 0 : _c.map((row) => (Object.assign(Object.assign({}, row), { attachment: row.attachment
            ? (0, response_1.HandelAttachmets)(row.attachment, req.protocol, req.get('host'), 'user_report')
            : undefined })));
    res.status(200).json({
        success: true,
        message: 'reports fetched successfully.',
        data: data,
        pagination: { page, limit, total, totalPages },
    });
}));
exports.getAllUsersReports = getAllUsersReports;
const getAllUsersObjections = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    const page = parseInt(req.query.page, 10) || 1;
    const limit = parseInt(req.query.limit, 10) || 10;
    const offset = (page - 1) * limit;
    const usersResult = yield (0, orm_util_1.executeQuery)('SELECT * FROM user_objections LIMIT ? OFFSET ?', [limit, offset]);
    const countResult = yield (0, orm_util_1.executeQuery)('SELECT COUNT(*) AS total FROM user_objections');
    const total = ((_b = (_a = countResult === null || countResult === void 0 ? void 0 : countResult.data) === null || _a === void 0 ? void 0 : _a[0]) === null || _b === void 0 ? void 0 : _b.total) || 0;
    const totalPages = Math.ceil(total / limit);
    res.status(200).json({
        success: true,
        message: 'objections fetched successfully.',
        data: usersResult.data,
        pagination: { page, limit, total, totalPages },
    });
}));
exports.getAllUsersObjections = getAllUsersObjections;
const changeUserReportStatus = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const id = req.params.id;
    const newStatus = req.body.status;
    const isReportFound = yield (0, orm_util_1.executeSingleQuery)('SELECT COUNT(*) as total FROM user_report WHERE id = ?', [id]);
    if (isReportFound && isReportFound.data) {
        console.log(isReportFound.data);
        if (isReportFound.data[0].total === 0) {
            res.status(404).json({
                status: false,
                message: `Report Not Found With ID ${id}`,
            });
            return;
        }
    }
    const data = yield (0, orm_util_1.executeQuery)('UPDATE user_report SET status = ? WHERE id = ?', [newStatus, id]);
    if (data.success) {
        res.status(200).json({
            success: true,
            message: 'Status updated successfully.',
            data: data.data,
        });
    }
    else {
        res.status(200).json({
            success: false,
            message: 'No changes were made. The status might already be set to the specified value.',
            data: data.data,
        });
    }
}));
exports.changeUserReportStatus = changeUserReportStatus;
const changeUserObjectionStatus = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const id = req.params.id;
    const newStatus = req.body.status;
    const isObjectionExisits = yield (0, orm_util_1.executeSingleQuery)('SELECT COUNT(*) as total FROM user_objections WHERE id = ?', [id]);
    if (isObjectionExisits && isObjectionExisits.data) {
        console.log(isObjectionExisits.data);
        if (isObjectionExisits.data[0].total === 0) {
            res.status(404).json({
                status: false,
                message: `Objection Not Found With ID ${id}`,
            });
            return;
        }
    }
    const data = yield (0, orm_util_1.executeQuery)('UPDATE user_objections SET status = ? WHERE id = ?', [newStatus, id]);
    if (data.success) {
        res.status(200).json({
            success: true,
            message: 'Status updated successfully.',
            data: data.data,
        });
    }
    else {
        res.status(200).json({
            success: false,
            message: 'No changes were made. The status might already be set to the specified value.',
            data: data.data,
        });
    }
}));
exports.changeUserObjectionStatus = changeUserObjectionStatus;
