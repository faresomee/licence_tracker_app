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
exports.searchForViolationsOnVehicle = exports.getAllViolationTicketActions = exports.getAllViolationTicket = exports.createVehicleTicket = void 0;
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const orm_util_1 = require("../utils/orm.util");
const multer_middleware_1 = require("../middleware/multer.middleware");
const dateFormat_util_1 = require("../utils/dateFormat.util");
exports.createVehicleTicket = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user;
    let attachmentPaths = [];
    if (req.files && Array.isArray(req.files) && req.files.length > 0) {
        const savedFiles = yield (0, multer_middleware_1.saveUploadedFiles)(req);
        attachmentPaths = savedFiles.map((filename) => `${filename}`);
        const query = `
        INSERT INTO violations 
        (police_id, plate_id, location, type, action, description, attachments , status )
        VALUES (?, ?, ?, ?, ?, ?,?,?)
      `;
        const values = [
            user.id,
            req.body.vehicle_plate,
            req.body.location,
            req.body.violation_type,
            req.body.action_taken,
            req.body.description,
            JSON.stringify(attachmentPaths),
            req.body.status,
        ];
        yield (0, orm_util_1.executeQuery)(query, values);
    }
    else {
        const query = `
            INSERT INTO violations 
            (police_id, plate_id, location, type, action, description , status )
            VALUES (?, ?, ?, ?, ?, ?,?)
        `;
        const values = [
            user.id,
            req.body.vehicle_plate,
            req.body.location,
            req.body.violation_type,
            req.body.action_taken,
            req.body.description,
            req.body.status || '',
        ];
        yield (0, orm_util_1.executeQuery)(query, values);
    }
    res.status(201).json({ success: true, message: 'Ticket created' });
}));
exports.getAllViolationTicket = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const query = `SELECT * FROM violation_type`;
    const result = yield (0, orm_util_1.executeQuery)(query);
    res.status(200).json({
        data: result,
    });
}));
exports.getAllViolationTicketActions = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const query = `SELECT * FROM violation_action`;
    const result = yield (0, orm_util_1.executeQuery)(query);
    res.status(200).json({
        data: result,
    });
}));
exports.searchForViolationsOnVehicle = (0, asyncHandler_1.default)(
// here
(req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const plate_id = req.params.plate_id;
    const searchForViolations = `SELECT 
vt.name,
v.create_at,
v.status
FROM violations v
JOIN violation_type vt ON vt.ID = v.type
WHERE v.plate_id = ?
;`;
    const searchForMoreInformation = `SELECT 
v.plate,
vl.color,
v.glass_type
FROM vehicle_license vl 
JOIN vehicle v ON vl.vehicle_plate = v.plate
WHERE v.plate = ?;`;
    const getDateOflicense = `SELECT 
vl.issue_date,
vl.expiry_date,
vl.inspection_date
FROM vehicle_license vl
WHERE vl.vehicle_plate = ?
;`;
    const vehicleInformationQuery = `SELECT 
veh.brand,
veh.name,
veh.chassis_number,
veh.engine_number
FROM vehicle veh
WHERE veh.plate = ?
;`;
    const trafficInformationQuery = `SELECT 
    drl.traffic_department,
    drl.traffic_office,
    p.full_name,
    p.address
FROM driver_license drl
JOIN person p ON drl.driver_id = p.national_id
JOIN vehicle_license vl ON vl.driving_license_id = drl.number
WHERE vl.vehicle_plate = ?;
`;
    const violationData = yield (0, orm_util_1.executeQuery)(searchForViolations, [plate_id]);
    const vehicleData = yield (0, orm_util_1.executeQuery)(searchForMoreInformation, [plate_id]);
    const licenseData = yield (0, orm_util_1.executeQuery)(getDateOflicense, [plate_id]);
    const vehicleInformation = yield (0, orm_util_1.executeQuery)(vehicleInformationQuery, [
        plate_id,
    ]);
    const traffic_infortmation = yield (0, orm_util_1.executeQuery)(trafficInformationQuery, [
        plate_id,
    ]);
    const licenseDataResult = Array.isArray(licenseData.data)
        ? licenseData.data.map((license) => {
            return Object.assign(Object.assign({}, license), { issue_date: (0, dateFormat_util_1.formatDateV2)(license.issue_date), expiry_date: (0, dateFormat_util_1.formatDateV2)(license.expiry_date), inspection_date: (0, dateFormat_util_1.formatDateV2)(license.inspection_date) });
        })
        : [];
    const result = {
        traffic_information: traffic_infortmation,
        vehicleInformation: vehicleInformation.data,
        vehicle: vehicleData.data,
        dates: licenseDataResult,
        violation: violationData.data,
    };
    res.status(200).json({
        data: result,
    });
}));
