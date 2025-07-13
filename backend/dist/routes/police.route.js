"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const police_controller_1 = require("../controller/police.controller");
const police_validation_1 = require("../validation/police.validation");
const validateRequest_1 = require("../middleware/validateRequest");
const police_user_access_1 = require("../auth/police_user.access");
const report_police_controller_1 = require("../controller/report.police.controller");
const reports_validation_1 = require("../validation/reports.validation");
const router = (0, express_1.Router)();
/**
 * @route   POST /api/police/generate-otp
 * @desc    Generate OTP for police user
 * @access  Public
 */
router
    .route('/generate-otp')
    .post(police_validation_1.generateOTPForLogin, validateRequest_1.validateRequest, police_controller_1.generateOTPRequest);
/**
 * @route   POST /api/police/generate-otp/password
 * @desc    Generate OTP for police user to reset password
 * @access  Private
 */
router
    .route('/generate-otp/password')
    .post(police_user_access_1.validatePoliceToken, police_controller_1.generateOTPRequestForPassword);
/**
 * @route   POST /api/police/change/password
 * @desc  Change password for police user
 * @access  Private
 */
router
    .route('/change/password')
    .post(police_user_access_1.validatePoliceToken, police_validation_1.changePasswordForPoliceUserValidation, validateRequest_1.validateRequest, police_controller_1.changePasswordForPoliceUser);
/**
 * @route   POST /api/police/login
 * @desc    Login for police user
 * @access  Public
 */
router
    .route('/login')
    .post(police_validation_1.loginPoliceUserValidation, validateRequest_1.validateRequest, police_controller_1.loginPoliceUser);
/**
 * @route   POST /api/police/logout
 * @desc    Logout for police user
 * @access  Private
 */
router.route('/logout').post(police_user_access_1.validatePoliceToken, police_controller_1.logoutPoliceUser);
/**
 * @route   GET /api/police/my-details
 * @desc    Get my details
 * @access  Private
 */
router.route('/my-details').get(police_user_access_1.validatePoliceToken, police_controller_1.getMyDetails);
/**
 * @route   GET /api/police/my-reports
 * @desc    Get my reports
 * @access  Private
 */
router.route('/my-reports').get(police_user_access_1.validatePoliceToken, report_police_controller_1.getMyReports);
/**
 * @route   POST /api/police/reports
 * @desc    Create a new Report
 * @access  Private
 */
router
    .route('/reports')
    .post(police_user_access_1.validatePoliceToken, reports_validation_1.createReportValidation, validateRequest_1.validateRequest, report_police_controller_1.CreateReport);
/**
 * @route   GET /api/police/reports/types
 * @desc    get all type of reports
 * @access  Private
 */
router.route('/reports/types').get(police_user_access_1.validatePoliceToken, report_police_controller_1.getAllReportTypes);
/**
 * @route   GET /api/police/reports/:id
 * @desc    Get a specific report
 * @access  Private
 */
router.route('/reports/:id').get(police_user_access_1.validatePoliceToken, report_police_controller_1.getSpesificReport);
/**
 * @route   GET /api/police/notification
 * @desc    GET a notification for police officer
 * @access  Private
 */
router.route('/notification').get(police_user_access_1.validatePoliceToken, police_controller_1.getMyNotification);
/**
 * @route   GET /api/police/statistics
 * @desc    GET a statistics for police officer
 * @access  Private
 */
router.route('/statistics').get(police_user_access_1.validatePoliceToken, police_controller_1.getMyStatistics);
/**
 * @route   GET /api/police/statistics
 * @desc    GET a statistics for police officer
 * @access  Private
 */
router.route('/urgent').get(police_user_access_1.validatePoliceToken, police_controller_1.getUrgentTasks);
/**
 * @route   GET /api/police/activites
 * @desc    GET a latest Activites
 * @access  Private
 */
router.route('/activites').get(police_user_access_1.validatePoliceToken, police_controller_1.getActivites);
exports.default = router;
