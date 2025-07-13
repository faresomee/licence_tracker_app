import { Router } from 'express'
import { getStatsitcsOfHome } from '../controller/Home.controller'
import { validateAdminToken } from '../middleware/admin.middleware'
const route = Router()

route.get('/', validateAdminToken, getStatsitcsOfHome)

export default route
