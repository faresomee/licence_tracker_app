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
exports.createReport = void 0;
const orm_util_1 = require("../utils/orm.util");
const createReport = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { title, description, status, priority, assigned_to, created_by } = req.body;
    const createReport = yield (0, orm_util_1.executeNonQuery)(`INSERT INTO reports (title, description, status, priority, assigned_to, created_by) VALUES (?, ?, ?, ?, ?, ?)`, [title, description, status, priority, assigned_to, created_by]);
    res.status(201).json({
        message: 'Report created successfully',
        data: createReport,
    });
});
exports.createReport = createReport;
