"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const police_user_access_1 = require("../auth/police_user.access");
const router = (0, express_1.Router)();
/**
 * @route   POST /api/report
 * @desc    Create a new report
 * @access  Police User only
 */
// router.route('/').post(validatePoliceToken, createReport)
router.route('/').post(police_user_access_1.validatePoliceToken, (req, res) => {
    res.status(200).json({ message: 'Report created successfully' });
});
exports.default = router;
