"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const police_user_access_1 = require("../auth/police_user.access");
const police_vehcile_controller_1 = require("../controller/police.vehcile.controller");
const express_1 = require("express");
const police_ticket_validation_1 = require("../validation/police.ticket.validation");
const validateRequest_1 = require("../middleware/validateRequest");
const multer_middleware_1 = require("../middleware/multer.middleware");
const router = (0, express_1.Router)();
/**
 * @route   GET /api/violation/
 * @desc    Get all violation tickets
 * @access  Private (Police)
 **/
router.route('/').get(police_user_access_1.validatePoliceToken, police_vehcile_controller_1.getAllViolationTicket);
/**
 * @route   GET /api/violation/actions
 * @desc    Get all violation tickets actions
 * @access  Private (Police)
 **/
router.route('/actions').get(police_user_access_1.validatePoliceToken, police_vehcile_controller_1.getAllViolationTicketActions);
/**
 * @route   POST /api/violation/
 * @desc    Create a new violation ticket
 * @access  Private (Police)
 **/
router
    .route('/')
    .post(police_user_access_1.validatePoliceToken, multer_middleware_1.uploadMultiFiles, police_ticket_validation_1.policeTicketValidation, validateRequest_1.validateRequest, police_vehcile_controller_1.createVehicleTicket);
/**
 * @route   GET /api/violation/vehicle/:plate_id
 * @desc    Search for a vehicle by plate ID
 * @access  Private (Police)
 **/
router
    .route('/vehicle/:plate_id')
    .get(police_user_access_1.validatePoliceToken, police_vehcile_controller_1.searchForViolationsOnVehicle);
exports.default = router;
