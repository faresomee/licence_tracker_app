import { Router } from 'express'
import {
  AddWantedVhecile,
  deleteWantedVehcile,
  getAllWantedVehicle,
  getSpesificVehicle,
} from '../controller/admin.vehcile.controller'
import { validateWantedVehicle } from '../validation/admin.veh'

const route = Router()

route.get('/', getAllWantedVehicle)
route.get('/:id', getSpesificVehicle)
route.post('/', validateWantedVehicle, AddWantedVhecile)
route.delete('/:id', deleteWantedVehcile)
export default route
