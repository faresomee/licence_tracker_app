"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const admin_controller_1 = require("../controller/admin.controller");
const admin_middleware_1 = require("../middleware/admin.middleware");
const multer_middleware_1 = require("../middleware/multer.middleware");
const admin_validation_1 = require("../validation/admin.validation");
const police_validation_1 = require("../validation/police.validation");
const validateRequest_1 = require("../middleware/validateRequest");
const router = (0, express_1.Router)();
/**
 * @route   POST /api/admin
 * @desc    Create a new admin user
 * @access  Private ( Admin only)
 */
router
    .route('/')
    .post(admin_middleware_1.validateAdminToken, multer_middleware_1.uploadFile, admin_validation_1.createAdminValidation, validateRequest_1.validateRequest, admin_controller_1.createAdmin);
router.route('/login').post(admin_validation_1.loginAdminValidation, validateRequest_1.validateRequest, admin_controller_1.loginAdmin);
/**
 * @route   GET /api/admin
 * @desc    Get all admin users
 * @access  Private (Admin only)
 */
router.route('/').get(admin_middleware_1.validateAdminToken, admin_controller_1.getAllAdmins);
/**
 * @route   GET /api/admin/:id
 * @desc    Get a single admin user by ID
 * @access  Private (Admin only)
 */
router.route('/:id').get(admin_middleware_1.validateAdminToken, admin_middleware_1.validateAdminId, admin_controller_1.getAdmin);
/**
 * @route   PUT /api/admin/:id
 * @desc    Update an admin user
 * @access  Private (Admin only)
 */
router
    .route('/:id')
    .put(admin_middleware_1.validateAdminToken, admin_middleware_1.validateAdminId, multer_middleware_1.uploadFile, admin_validation_1.updateAdminValidation, validateRequest_1.validateRequest, admin_controller_1.updateAdmin);
/**
 * @route   DELETE /api/admin/:id
 * @desc    Delete an admin user
 * @access  Private ( Admin only)
 */
router.route('/:id').delete(admin_middleware_1.validateAdminToken, admin_middleware_1.validateAdminId, admin_controller_1.deleteAdmin);
// User Routes
/**
 * @route   POST /api/admin/police/create-user
 * @desc    Create a new police user
 * @access  Private ( Admin )
 */
router
    .route('/police/create-user')
    .post(admin_middleware_1.validateAdminToken, multer_middleware_1.uploadFile, police_validation_1.createPoliceUserValidation, validateRequest_1.validateRequest, admin_controller_1.createUser);
/**
 * @route   GET /api/admin/police/users
 * @desc    Get all police users
 * @access  Private ( Admin )
 */
router.route('/police/users').get(admin_middleware_1.validateAdminToken, admin_controller_1.getAllUsers);
/**
 * @route   GET /api/admin/police/user/:id
 * @desc    Get a single police user by ID
 * @access  Private ( Admin )
 */
router.route('/police/user/:id').get(admin_middleware_1.validateAdminToken, admin_controller_1.getUser);
/**
 * @route   DELETE /api/admin/police/user/:id
 * @desc    Delete a police user by ID
 * @access  Private ( Admin )
 */
router.route('/police/user/:id').delete(admin_middleware_1.validateAdminToken, admin_controller_1.deleteUser);
/**
 * @route   PUT /api/admin/police/user/:id
 * @desc    Update a police user by ID
 * @access  Private ( Admin )
 */
router
    .route('/police/user/:id')
    .put(admin_middleware_1.validateAdminToken, multer_middleware_1.uploadFile, police_validation_1.updatePoliceUserValidation, validateRequest_1.validateRequest, admin_controller_1.updateUser);
router.get('/vehciles/get', admin_middleware_1.validateAdminToken, admin_controller_1.getAllVheciles);
router.get('/accounts/users', admin_middleware_1.validateAdminToken, admin_controller_1.getAllUsersAccounts);
router.get('/accounts/users/reports', admin_middleware_1.validateAdminToken, admin_controller_1.getAllUsersReports);
router.get('/accounts/users/objection', admin_middleware_1.validateAdminToken, admin_controller_1.getAllUsersObjections);
router.put('/accounts/users/reports/:id', admin_middleware_1.validateAdminToken, admin_validation_1.changeStatusReport, validateRequest_1.validateRequest, admin_controller_1.changeUserReportStatus);
router.put('/accounts/users/objection/:id', admin_middleware_1.validateAdminToken, admin_validation_1.changeStatusObjection, validateRequest_1.validateRequest, admin_controller_1.changeUserObjectionStatus);
exports.default = router;
