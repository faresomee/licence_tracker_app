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
exports.deleteWantedVehcile = exports.AddWantedVhecile = exports.getSpesificVehicle = exports.getAllWantedVehicle = void 0;
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const orm_util_1 = require("../utils/orm.util");
exports.getAllWantedVehicle = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const countQuery = `SELECT COUNT(*) as total FROM wanted_vehicle`;
    const countResult = yield (0, orm_util_1.executeQuery)(countQuery, []);
    let total = 0;
    if (countResult && countResult.data) {
        total = countResult.data[0].total;
    }
    const dataQuery = `
    SELECT id,plate, location, description, created_at
    FROM wanted_vehicle
    ORDER BY created_at DESC
    LIMIT ? OFFSET ?
  `;
    const data = yield (0, orm_util_1.executeQuery)(dataQuery, [limit, offset]);
    res.json({
        data,
        pagination: {
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        },
    });
}));
exports.getSpesificVehicle = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const query = `SELECT * FROM wanted_vehicle WHERE id = ? LIMIT 1`;
    const results = yield (0, orm_util_1.executeQuery)(query, [id]);
    if (results && results.data) {
        res.status(200).json(results.data ? results.data[0] : results.data);
    }
}));
exports.AddWantedVhecile = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { plate, location, description } = req.body;
    const insertQuery = `
    INSERT INTO wanted_vehicle (plate, location, description)
    VALUES (?, ?, ?)
  `;
    const result = yield (0, orm_util_1.executeQuery)(insertQuery, [
        plate,
        location,
        description,
    ]);
    res.status(201).json({
        message: 'Wanted vehicle added successfully',
    });
}));
exports.deleteWantedVehcile = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const checkQuery = `SELECT * FROM wanted_vehicle WHERE id = ?`;
    const result = yield (0, orm_util_1.executeQuery)(checkQuery, [id]);
    let total = 0;
    if (result && result.data) {
        total = result.data[0].total;
    }
    const deleteQuery = `DELETE FROM wanted_vehicle WHERE id = ?`;
    yield (0, orm_util_1.executeQuery)(deleteQuery, [id]);
    res.json({ message: 'Wanted vehicle deleted successfully' });
}));
