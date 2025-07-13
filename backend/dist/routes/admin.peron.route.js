"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const admin_middleware_1 = require("../middleware/admin.middleware");
const admin_person_controller_1 = require("../controller/admin.person.controller");
const person_validation_1 = require("../validation/person.validation");
const validateRequest_1 = require("../middleware/validateRequest");
const router = (0, express_1.Router)();
/**
 * @route   GET /api/person/admin
 * @desc    Get all wanted persons
 * @access  Private (Admin only)
 **/
router.route('/get/wanted').get(admin_middleware_1.validateAdminToken, admin_person_controller_1.getAllWantedPersons);
/**
 * @route   GET /api/person/admin
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/
router
    .route('/:id')
    .get(admin_middleware_1.validateAdminToken, person_validation_1.PersonValidation, validateRequest_1.validateRequest, admin_person_controller_1.getPersonByID);
/**
 * @route   GET /api/person/admin
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/
router.route('/').get(admin_middleware_1.validateAdminToken, admin_person_controller_1.getPersons);
/**
 * @route   PUT /api/person/admin/:id/criminal-status
 * @desc    Change Criminal Status
 * @access  Private ( Admin only)
 **/
router
    .route('/:id/criminal-status')
    .put(admin_middleware_1.validateAdminToken, person_validation_1.PersonValidation, person_validation_1.PersonCriminalStatusValidation, validateRequest_1.validateRequest, admin_person_controller_1.changeCriminalStatus);
exports.default = router;
