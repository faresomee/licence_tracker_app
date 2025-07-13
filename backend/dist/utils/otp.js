"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getOTP = exports.sendOTP = void 0;
const orm_util_1 = require("./orm.util");
const generateOTP = (length = 4) => {
    const characters = '0123456789';
    let otp = '';
    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        otp += characters[randomIndex];
    }
    return otp;
};
const deleteExpiredOTP = (userID) => __awaiter(void 0, void 0, void 0, function* () {
    const deleteQuery = 'DELETE FROM sms_otp WHERE police_id = ?';
    yield (0, orm_util_1.executeQuery)(deleteQuery, [userID]);
});
const checkOTPExists = (userID, typeOfOTP) => __awaiter(void 0, void 0, void 0, function* () {
    const query = `
        SELECT created_at 
        FROM sms_otp 
        WHERE police_id = ? 
          AND created_at >= NOW() - INTERVAL 5 MINUTE
          AND type = ?
        ORDER BY created_at DESC 
        LIMIT 1
    `;
    const result = yield (0, orm_util_1.executeQuery)(query, [userID, typeOfOTP]);
    if (!result.data || result.data.length === 0) {
        yield deleteExpiredOTP(userID);
        return false;
    }
    return true;
});
const sendOTP = (phoneNumber, userID, typeOfOTP) => __awaiter(void 0, void 0, void 0, function* () {
    const otpStillValid = yield checkOTPExists(userID, typeOfOTP);
    if (otpStillValid) {
        console.log('OTP already sent and still valid. Try again later.');
        return;
    }
    const otp = generateOTP(4);
    console.log('OTP ' + otp + ' SENT to ' + phoneNumber);
    if (typeOfOTP === 'login') {
        const insertQuery = 'INSERT INTO sms_otp (otp, police_id,type) VALUES (?, ?,?)';
        yield (0, orm_util_1.executeQuery)(insertQuery, [otp, userID, 'login']);
    }
    else if (typeOfOTP === 'password') {
        const insertQuery = 'INSERT INTO sms_otp (otp, police_id,type) VALUES (?, ?,?)';
        yield (0, orm_util_1.executeQuery)(insertQuery, [otp, userID, 'password']);
    }
});
exports.sendOTP = sendOTP;
const getOTP = (userID, typeOfOtp) => __awaiter(void 0, void 0, void 0, function* () {
    const query = `
  SELECT otp 
  FROM sms_otp 
  WHERE police_id = ? AND type = ?
  ORDER BY created_at DESC
  LIMIT 1
`;
    const result = yield (0, orm_util_1.executeQuery)(query, [userID, typeOfOtp]);
    console.log('type of otp', typeOfOtp);
    console.log('otp FROM GET OTP METHOD', result);
    const data = result.data;
    if (!data || data.length === 0) {
        return null;
    }
    const otp = data[0].otp;
    return otp || null;
});
exports.getOTP = getOTP;
