"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const report_admin_controller_1 = require("../controller/report.admin.controller");
const admin_middleware_1 = require("../middleware/admin.middleware");
const validateRequest_1 = require("../middleware/validateRequest");
const reports_validation_1 = require("../validation/reports.validation");
const router = (0, express_1.Router)();
/**
 * @route   GET /api/admin/reports/types
 * @desc    get all Types of reports
 * @access  Private ( Admin only)
 **/
router.route('/types').get(admin_middleware_1.validateAdminToken, report_admin_controller_1.getAllReportTypes);
/**
 * @route   GET /api/admin/reports
 * @desc    get all reports
 * @access  Private ( Admin only)
 **/
router.route('/').get(admin_middleware_1.validateAdminToken, report_admin_controller_1.getAllReports);
/**
 * @route   GET /api/admin/reports/:id
 * @desc    get spesific report by id
 * @access  Private ( Admin only)
 **/
router.route('/:id').get(admin_middleware_1.validateAdminToken, report_admin_controller_1.getSpesificReport);
/**
 * @route   DELETE /api/admin/reports/:id
 * @desc    delete report by id
 * @access  Private ( Admin only)
 **/
router.route('/:id').delete(admin_middleware_1.validateAdminToken, report_admin_controller_1.deleteReport);
/**
 * @route   PUT /api/admin/reports/:id
 * @desc    update report by id
 * @access  Private ( Admin only)
 **/
router.route('/:id').put(admin_middleware_1.validateAdminToken, report_admin_controller_1.changeReportStatus);
/**
 * @route   PUT /api/admin/reports/:id
 * @desc    update report by id
 * @access  Private ( Admin only)
 **/
router
    .route('/')
    .post(admin_middleware_1.validateAdminToken, reports_validation_1.createReportTypeValidation, validateRequest_1.validateRequest, report_admin_controller_1.createReportType);
exports.default = router;
