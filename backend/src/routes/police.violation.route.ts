import { validatePoliceToken } from '../auth/police_user.access'
import {
  createVehicleTicket,
  getAllViolationTicket,
  getAllViolationTicketActions,
  searchForViolationsOnVehicle,
} from '../controller/police.vehcile.controller'
import { Router } from 'express'
import { policeTicketValidation } from '../validation/police.ticket.validation'
import { validateRequest } from '../middleware/validateRequest'
import { uploadMultiFiles } from '../middleware/multer.middleware'

const router = Router()

/**
 * @route   GET /api/violation/
 * @desc    Get all violation tickets
 * @access  Private (Police)
 **/
router.route('/').get(validatePoliceToken, getAllViolationTicket)

/**
 * @route   GET /api/violation/actions
 * @desc    Get all violation tickets actions
 * @access  Private (Police)
 **/
router.route('/actions').get(validatePoliceToken, getAllViolationTicketActions)

/**
 * @route   POST /api/violation/
 * @desc    Create a new violation ticket
 * @access  Private (Police)
 **/
router
  .route('/')
  .post(
    validatePoliceToken,
    uploadMultiFiles,
    policeTicketValidation,
    validateRequest,
    createVehicleTicket,
  )

/**
 * @route   GET /api/violation/vehicle/:plate_id
 * @desc    Search for a vehicle by plate ID
 * @access  Private (Police)
 **/
router
  .route('/vehicle/:plate_id')
  .get(validatePoliceToken, searchForViolationsOnVehicle)
export default router
