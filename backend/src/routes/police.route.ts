import { Router } from 'express'
import {
  changePasswordForPoliceUser,
  generateOTPRequest,
  generateOTPRequestForPassword,
  getActivites,
  getMyDetails,
  getMyNotification,
  getMyStatistics,
  getUrgentTasks,
  loginPoliceUser,
  logoutPoliceUser,
} from '../controller/police.controller'
import {
  changePasswordForPoliceUserValidation,
  generateOTPForLogin,
  loginPoliceUserValidation,
} from '../validation/police.validation'
import { validateRequest } from '../middleware/validateRequest'
import { validatePoliceToken } from '../auth/police_user.access'
import {
  CreateReport,
  getAllReportTypes,
  getMyReports,
  getSpesificReport,
} from '../controller/report.police.controller'
import { createReportValidation } from '../validation/reports.validation'
const router = Router()

/**
 * @route   POST /api/police/generate-otp
 * @desc    Generate OTP for police user
 * @access  Public
 */
router
  .route('/generate-otp')
  .post(generateOTPForLogin, validateRequest, generateOTPRequest)

/**
 * @route   POST /api/police/generate-otp/password
 * @desc    Generate OTP for police user to reset password
 * @access  Private
 */
router
  .route('/generate-otp/password')
  .post(validatePoliceToken, generateOTPRequestForPassword)

/**
 * @route   POST /api/police/change/password
 * @desc  Change password for police user
 * @access  Private
 */
router
  .route('/change/password')
  .post(
    validatePoliceToken,
    changePasswordForPoliceUserValidation,
    validateRequest,
    changePasswordForPoliceUser,
  )

/**
 * @route   POST /api/police/login
 * @desc    Login for police user
 * @access  Public
 */
router
  .route('/login')
  .post(loginPoliceUserValidation, validateRequest, loginPoliceUser)

/**
 * @route   POST /api/police/logout
 * @desc    Logout for police user
 * @access  Private
 */
router.route('/logout').post(validatePoliceToken, logoutPoliceUser)

/**
 * @route   GET /api/police/my-details
 * @desc    Get my details
 * @access  Private
 */
router.route('/my-details').get(validatePoliceToken, getMyDetails)

/**
 * @route   GET /api/police/my-reports
 * @desc    Get my reports
 * @access  Private
 */

router.route('/my-reports').get(validatePoliceToken, getMyReports)

/**
 * @route   POST /api/police/reports
 * @desc    Create a new Report
 * @access  Private
 */

router
  .route('/reports')
  .post(
    validatePoliceToken,
    createReportValidation,
    validateRequest,
    CreateReport,
  )

/**
 * @route   GET /api/police/reports/types
 * @desc    get all type of reports
 * @access  Private
 */

router.route('/reports/types').get(validatePoliceToken, getAllReportTypes)

/**
 * @route   GET /api/police/reports/:id
 * @desc    Get a specific report
 * @access  Private
 */

router.route('/reports/:id').get(validatePoliceToken, getSpesificReport)

/**
 * @route   GET /api/police/notification
 * @desc    GET a notification for police officer
 * @access  Private
 */
router.route('/notification').get(validatePoliceToken, getMyNotification)

/**
 * @route   GET /api/police/statistics
 * @desc    GET a statistics for police officer
 * @access  Private
 */
router.route('/statistics').get(validatePoliceToken, getMyStatistics)

/**
 * @route   GET /api/police/statistics
 * @desc    GET a statistics for police officer
 * @access  Private
 */
router.route('/urgent').get(validatePoliceToken, getUrgentTasks)

/**
 * @route   GET /api/police/activites
 * @desc    GET a latest Activites
 * @access  Private
 */
router.route('/activites').get(validatePoliceToken, getActivites)

export default router
