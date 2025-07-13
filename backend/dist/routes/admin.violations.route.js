"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const admin_middleware_1 = require("../middleware/admin.middleware");
const admin_controller_1 = require("../controller/admin.controller");
const admin_validation_1 = require("../validation/admin.validation");
const validateRequest_1 = require("../middleware/validateRequest");
const multer_middleware_1 = require("../middleware/multer.middleware");
const router = (0, express_1.Router)();
/*
 * @route   GET /api/custome/getSpesific
 * @desc    Get All violations
 * @access  Private ( Admin )
 */
router.route('/getSpesific/:id').get(admin_middleware_1.validateAdminToken, admin_controller_1.getSpesificViolation);
/**
 * @route   GET /api/custome/getAllViolations
 * @desc    Get All violations
 * @access  Private ( Admin )
 */
router.route('/violations').get(admin_middleware_1.validateAdminToken, admin_controller_1.getAllViolations);
/**
 * @route   GET /api/custome/type
 * @desc    Get All violations type
 * @access  Private ( Admin )
 */
router.route('/type').get(admin_middleware_1.validateAdminToken, admin_controller_1.getViolationsType);
/**
 * @route   POST /api/custome/createViolation
 * @desc    Create a new violation
 * @access  Private (Admin only)
 */
router
    .route('/createViolation')
    .post(admin_middleware_1.validateAdminToken, multer_middleware_1.uploadMultiFiles, admin_validation_1.createViolationAdmin, validateRequest_1.validateRequest, admin_controller_1.createViolationForAdmin);
/**
 * @route   DELETE /api/custome/deleteViolation/:id
 * @desc    Delete a violation by ID
 * @access  Private (Admin only)
 */
router
    .route('/deleteViolation/:id')
    .delete(admin_middleware_1.validateAdminToken, admin_controller_1.deleteViolationByAdmin);
/**
 * @route   PUT /api/custome/updateViolation/:id
 * @desc    Update a violation by ID
 * @access  Private (Admin only)
 */
router
    .route('/updateViolation/:id')
    .put(admin_middleware_1.validateAdminToken, admin_controller_1.updateViolationByAdmin);
exports.default = router;
