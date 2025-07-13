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
exports.changeCriminalStatus = exports.getAllWantedPersons = exports.getPersons = exports.getPersonByID = void 0;
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const orm_util_1 = require("../utils/orm.util");
const dateFormat_util_1 = require("../utils/dateFormat.util");
exports.getPersonByID = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const query = `
      SELECT 
        -- Person data
        p.national_id,
        p.full_name,
        p.gender,
        p.date_of_birth,
        p.social_status,
        p.religion,
        p.address,
        p.issue_date AS person_issue_date,
        p.expired_date AS person_expired_date,
        p.criminal_status,

        -- Vehicle and license info
        vl.issue_date AS vehicle_issue_date,
        vl.expiry_date AS vehicle_expiry_date,
        vl.color,
        vl.type AS vehicle_license_type,
        v.plate,
        v.brand,
        v.type AS vehicle_type,
        v.chassis_number,
        v.engine_number,
        dl.traffic_department,
        dl.traffic_office
      FROM person p
      LEFT JOIN driver_license dl ON p.national_id = dl.driver_id
      LEFT JOIN vehicle_license vl ON vl.driving_license_id = dl.number
      LEFT JOIN vehicle v ON v.plate = vl.vehicle_plate
      WHERE p.national_id = ?
    `;
    const result = yield (0, orm_util_1.executeQuery)(query, [id]);
    if (!result.data || result.data.length === 0) {
        res.status(404).json({ message: 'Person not found' });
        return;
    }
    const formattedPerson = {
        national_id: result.data[0].national_id,
        full_name: result.data[0].full_name,
        gender: result.data[0].gender,
        date_of_birth: (0, dateFormat_util_1.formatDateV2)(result.data[0].date_of_birth),
        social_status: result.data[0].social_status,
        religion: result.data[0].religion,
        address: result.data[0].address,
        issue_date: (0, dateFormat_util_1.formatDateV2)(result.data[0].person_issue_date),
        expired_date: (0, dateFormat_util_1.formatDateV2)(result.data[0].person_expired_date),
        criminal_status: result.data[0].criminal_status === 1 ? 'مطلوب' : 'غير مطلوب',
    };
    const vehicles = result.data
        .filter((v) => v.plate) // Ignore null plates
        .map((v) => ({
        plate_number: v.plate,
        brand: v.brand,
        vehicle_type: v.vehicle_type,
        chassis_number: v.chassis_number,
        engine_number: v.engine_number,
        color: v.color,
        issue_date: (0, dateFormat_util_1.formatDateV2)(v.vehicle_issue_date),
        expiry_date: (0, dateFormat_util_1.formatDateV2)(v.vehicle_expiry_date),
        traffic_unit: v.traffic_office,
        traffic_department: v.traffic_department,
    }));
    res.status(200).json({
        person: formattedPerson,
        vehicles,
    });
}));
exports.getPersons = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const countResult = yield (0, orm_util_1.executeSingleQuery)('SELECT COUNT(*) as total FROM person');
    const query = 'SELECT * FROM person LIMIT ? OFFSET ?';
    const persons = yield (0, orm_util_1.executeQuery)(query, [limit, offset]);
    const PersonsData = persons.data
        ? persons.data.map((person) => {
            return Object.assign(Object.assign({}, person), { date_of_birth: (0, dateFormat_util_1.formatDateV2)(person.date_of_birth), issue_date: (0, dateFormat_util_1.formatDateV2)(person.issue_date), expired_date: (0, dateFormat_util_1.formatDateV2)(person.expired_date), criminal_status: person.criminal_status === 1 ? 'مطلوب' : 'غير مطلوب' });
        })
        : [];
    if (countResult && countResult.data)
        res.status(200).json({
            success: true,
            data: PersonsData,
            pagination: {
                total: countResult.data[0].total,
                totalPages: Math.ceil(countResult.data[0].total / limit),
                page: page,
                limit: limit,
            },
        });
}));
exports.getAllWantedPersons = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b, _c;
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const dataQuery = `SELECT 
    national_id,
    full_name,
    address,
    date_of_birth,
    criminal_status
  FROM person 
  WHERE criminal_status = 1 
  LIMIT ? OFFSET ?`;
    const data = yield (0, orm_util_1.executeQuery)(dataQuery, [limit, offset]);
    const countQuery = `SELECT COUNT(*) AS total FROM person WHERE criminal_status = 1`;
    const countResult = yield (0, orm_util_1.executeQuery)(countQuery);
    const total = ((_b = (_a = countResult.data) === null || _a === void 0 ? void 0 : _a[0]) === null || _b === void 0 ? void 0 : _b.total) || 0;
    const totalPages = Math.ceil(total / limit);
    const formattedData = ((_c = data.data) === null || _c === void 0 ? void 0 : _c.map((person) => (Object.assign(Object.assign({}, person), { date_of_birth: (0, dateFormat_util_1.formatDateV2)(person.date_of_birth), criminal_status: person.criminal_status == 1 ? 'مطلوب' : 'غير مطلوب' })))) || [];
    res.status(200).json({
        page,
        limit,
        total,
        totalPages,
        data: formattedData,
    });
}));
exports.changeCriminalStatus = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const { criminal_status } = req.body;
    const query = `UPDATE person SET criminal_status = ? WHERE national_id = ?`;
    const result = yield (0, orm_util_1.executeQuery)(query, [criminal_status, id]);
    res.status(200).json({ message: 'Criminal status updated successfully' });
}));
