import { Router } from 'express'
import { validateAdminToken } from '../middleware/admin.middleware'
import {
  createViolationForAdmin,
  deleteViolationByAdmin,
  getAllViolations,
  getSpesificViolation,
  getViolationsType,
  updateViolationByAdmin,
} from '../controller/admin.controller'
import { createViolationAdmin } from '../validation/admin.validation'
import { validateRequest } from '../middleware/validateRequest'
import { uploadMultiFiles } from '../middleware/multer.middleware'
const router = Router()

/*
 * @route   GET /api/custome/getSpesific
 * @desc    Get All violations
 * @access  Private ( Admin )
 */
router.route('/getSpesific/:id').get(validateAdminToken, getSpesificViolation)
/**
 * @route   GET /api/custome/getAllViolations
 * @desc    Get All violations
 * @access  Private ( Admin )
 */
router.route('/violations').get(validateAdminToken, getAllViolations)

/**
 * @route   GET /api/custome/type
 * @desc    Get All violations type
 * @access  Private ( Admin )
 */
router.route('/type').get(validateAdminToken, getViolationsType)

/**
 * @route   POST /api/custome/createViolation
 * @desc    Create a new violation
 * @access  Private (Admin only)
 */
router
  .route('/createViolation')
  .post(
    validateAdminToken,
    uploadMultiFiles,
    createViolationAdmin,
    validateRequest,
    createViolationForAdmin,
  )

/**
 * @route   DELETE /api/custome/deleteViolation/:id
 * @desc    Delete a violation by ID
 * @access  Private (Admin only)
 */
router
  .route('/deleteViolation/:id')
  .delete(validateAdminToken, deleteViolationByAdmin)

/**
 * @route   PUT /api/custome/updateViolation/:id
 * @desc    Update a violation by ID
 * @access  Private (Admin only)
 */
router
  .route('/updateViolation/:id')
  .put(validateAdminToken, updateViolationByAdmin)
export default router
