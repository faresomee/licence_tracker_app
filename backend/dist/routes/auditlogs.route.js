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
const express_1 = require("express");
const orm_util_1 = require("../utils/orm.util");
const router = (0, express_1.Router)();
router.get('/', function (req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a, _b;
        try {
            const { page, limit } = req.query;
            const pageNumber = parseInt(page) || 1;
            const limitNumber = parseInt(limit) || 10;
            const offset = (pageNumber - 1) * limitNumber;
            const query = `SELECT * FROM AuditLogs ORDER BY created_at DESC LIMIT ${limitNumber} OFFSET ${offset}`;
            const auditLogs = yield (0, orm_util_1.executeQuery)(query);
            const totalQuery = `SELECT COUNT(*) FROM AuditLogs`;
            const totalResult = yield (0, orm_util_1.executeQuery)(totalQuery);
            res.status(200).json({
                data: auditLogs,
                total: ((_b = (_a = totalResult.data) === null || _a === void 0 ? void 0 : _a[0]) === null || _b === void 0 ? void 0 : _b['COUNT(*)']) || 0,
                page: pageNumber,
                limit: limitNumber,
            });
        }
        catch (error) {
            res.status(500).json({ error: 'Failed to fetch audit logs ' + error });
        }
    });
});
exports.default = router;
