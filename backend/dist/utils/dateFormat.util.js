"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.validDate = exports.getFullDate = exports.getRealTime = exports.getHouers = exports.formatDateV2 = exports.formatDate = void 0;
const dayjs_1 = __importDefault(require("dayjs"));
require("dayjs/locale/ar");
const advancedFormat_1 = __importDefault(require("dayjs/plugin/advancedFormat"));
dayjs_1.default.extend(advancedFormat_1.default);
dayjs_1.default.locale('ar');
const formatDate = (dateString) => {
    return (0, dayjs_1.default)(dateString).format('D MMMM YYYY');
};
exports.formatDate = formatDate;
const formatDateV2 = (dateString) => {
    return (0, dayjs_1.default)(dateString).format('DD/MM/YYYY');
};
exports.formatDateV2 = formatDateV2;
const getHouers = (dateString) => {
    return (0, dayjs_1.default)(dateString).format('HH:mm');
};
exports.getHouers = getHouers;
const getRealTime = (dateString) => {
    return (0, dayjs_1.default)(dateString).format('HH:mm:ss');
};
exports.getRealTime = getRealTime;
const getFullDate = (dateString) => {
    return (0, dayjs_1.default)(dateString).format('YYYY-MM-DD (HH:mm)');
};
exports.getFullDate = getFullDate;
const validDate = (dateString) => {
    const currentDate = new Date();
    const inputDate = new Date(dateString);
    if (inputDate < currentDate) {
        return 'expired';
    }
    return 'valid';
};
exports.validDate = validDate;
