"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const admin_middleware_1 = require("../middleware/admin.middleware");
const vehicle_middleware_1 = require("../middleware/vehicle.middleware");
const vehicle_controller_1 = require("../controller/vehicle.controller");
const router = (0, express_1.Router)();
/**
 * @route   POST /api/vehicle/
 * @desc    create vehicle
 * @access  Private [Admin]
 */
router.post('/', admin_middleware_1.validateAdminToken, vehicle_middleware_1.validateCreateVehicleBody, vehicle_controller_1.createVehicle);
exports.default = router;
