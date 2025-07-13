"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const Home_controller_1 = require("../controller/Home.controller");
const admin_middleware_1 = require("../middleware/admin.middleware");
const route = (0, express_1.Router)();
route.get('/', admin_middleware_1.validateAdminToken, Home_controller_1.getStatsitcsOfHome);
exports.default = route;
