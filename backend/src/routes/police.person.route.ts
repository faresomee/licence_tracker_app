import { Router } from 'express'
import { getPersonByID } from '../controller/admin.person.controller'
import { validatePoliceToken } from '../auth/police_user.access'
import { getLicnseByID } from '../controller/police.person.controller'
const router = Router()

/**
 * @route   GET /api/person/police/:id
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/
router.route('/:id').get(validatePoliceToken, getPersonByID)

/**
 * @route   GET /api/person/police/license/:id
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/
router.route('/license/:id').get(validatePoliceToken, getLicnseByID)

export default router
