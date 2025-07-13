"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const admin_person_controller_1 = require("../controller/admin.person.controller");
const police_user_access_1 = require("../auth/police_user.access");
const police_person_controller_1 = require("../controller/police.person.controller");
const router = (0, express_1.Router)();
/**
 * @route   GET /api/person/police/:id
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/
router.route('/:id').get(police_user_access_1.validatePoliceToken, admin_person_controller_1.getPersonByID);
/**
 * @route   GET /api/person/police/license/:id
 * @desc    get Person Using ID
 * @access  Private ( Admin only)
 **/
router.route('/license/:id').get(police_user_access_1.validatePoliceToken, police_person_controller_1.getLicnseByID);
exports.default = router;
