import { Router } from 'express'
import { validateAdminToken } from '../middleware/admin.middleware'
import {
  changeCriminalStatus,
  getAllWantedPersons,
  getPersonByID,
  getPersons,
} from '../controller/admin.person.controller'
import {
  PersonCriminalStatusValidation,
  PersonValidation,
} from '../validation/person.validation'
import { validateRequest } from '../middleware/validateRequest'
const router = Router()

/**
 * @route   GET /api/person/admin
 * @desc    Get all wanted persons
 * @access  Private (Admin only)
 **/

router.route('/get/wanted').get(validateAdminToken, getAllWantedPersons)

/**
 * @route   GET /api/person/admin
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/
router
  .route('/:id')
  .get(validateAdminToken, PersonValidation, validateRequest, getPersonByID)

/**
 * @route   GET /api/person/admin
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/

router.route('/').get(validateAdminToken, getPersons)

/**
 * @route   PUT /api/person/admin/:id/criminal-status
 * @desc    Change Criminal Status
 * @access  Private ( Admin only)
 **/
router
  .route('/:id/criminal-status')
  .put(
    validateAdminToken,
    PersonValidation,
    PersonCriminalStatusValidation,
    validateRequest,
    changeCriminalStatus,
  )
export default router
