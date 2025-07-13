import { Router } from 'express'
import {
  createReport,
  generateObjection,
  getReport,
  login,
  register,
  searchVehcile,
} from '../controller/user.controller'
import {
  userReportValidation,
  validateUser,
  validateUserLogin,
  validateUserObjection,
} from '../validation/user.validation'
import { validateRequest } from '../middleware/validateRequest'
import { validateUserToken } from '../auth/user.access'
import { uploadMultiFiles } from '../middleware/multer.middleware'
const route = Router()

route.post('/register', validateUser, validateRequest, register)

route.post('/login', validateUserLogin, validateRequest, login)

route.get('/veh/:id', validateUserToken, searchVehcile)

route.post(
  '/report',
  validateUserToken,
  uploadMultiFiles,
  userReportValidation,
  validateRequest,
  createReport,
)
route.get('/report/:id', validateUserToken, getReport)

route.post(
  '/objection',
  validateUserToken,
  validateUserObjection,
  validateRequest,
  generateObjection,
)
export default route
