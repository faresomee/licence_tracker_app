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
exports.getAllReportTypes = exports.CreateReport = exports.getSpesificReport = exports.getMyReports = void 0;
const orm_util_1 = require("../utils/orm.util");
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const dateFormat_util_1 = require("../utils/dateFormat.util");
const crypto_1 = __importDefault(require("crypto"));
exports.getMyReports = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user;
    const result = yield (0, orm_util_1.executeQuery)('SELECT r.id , r.title , r.description , r.status , r.date, rt.name AS report_type_name FROM reports AS r RIGHT JOIN police_reports AS pr ON pr.report_id = r.id LEFT JOIN report_type as rt ON r.type = rt.id WHERE pr.police_id = ?', [user.id]);
    if (result.success && result.data) {
        const userData = result.data.map((report) => {
            return Object.assign(Object.assign({}, report), { date: (0, dateFormat_util_1.formatDate)(report.date) });
        });
        res.status(200).json({
            success: true,
            data: userData || [],
        });
    }
    else {
        res.status(404).json({
            success: false,
            message: 'No reports found for the user',
        });
    }
}));
exports.getSpesificReport = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = req.user;
    const reportId = req.params.id;
    const result = yield (0, orm_util_1.executeQuery)('SELECT rp.id , rp.title , rp.description , rp.status , rp.date, tp.name AS report_type_name FROM reports AS rp RIGHT JOIN police_reports AS pr ON rp.id = pr.report_id LEFT JOIN report_type AS tp ON rp.type = tp.id WHERE  pr.police_id = ? AND rp.id LIKE ? ;', [user.id, `%${reportId}%`]);
    if (result.success && result.data) {
        const userData = result.data.map((report) => {
            return Object.assign(Object.assign({}, report), { date: (0, dateFormat_util_1.formatDate)(report.date) });
        });
        res.status(200).json({
            success: true,
            data: userData || [],
        });
    }
    else {
        res.status(404).json({
            success: false,
            message: 'No reports found for the user',
        });
    }
}));
exports.CreateReport = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { title, type, description } = req.body;
    const id = crypto_1.default.randomUUID().replace(/-/g, '');
    const user = req.user;
    const reportQuery = yield (0, orm_util_1.executeNonQuery)('INSERT INTO reports (id , title , description ,type) VALUES(?, ?, ? , ?)', [id, title, description, type]);
    const linkQuery = yield (0, orm_util_1.executeNonQuery)('INSERT INTO police_reports (police_id , report_id ) VALUES(?, ?)', [user.id, id]);
    if (reportQuery.success && linkQuery.success) {
        res.status(201).json({
            success: true,
            message: `Report created successfully With id ${id}`,
        });
    }
    else {
        res.status(500).json({
            success: false,
            message: 'Failed to create report',
        });
    }
}));
exports.getAllReportTypes = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const result = yield (0, orm_util_1.executeQuery)('SELECT * FROM report_type', []);
    if (result.success && result.data) {
        res.status(200).json({
            success: true,
            data: result.data || [],
        });
    }
    else {
        res.status(404).json({
            success: false,
            message: 'No report types found',
        });
    }
}));
exports = {
    getMyReports: exports.getMyReports,
    CreateReport: exports.CreateReport,
    getSpesificReport: exports.getSpesificReport,
    getAllReportTypes: exports.getAllReportTypes,
};
