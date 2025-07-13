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
exports.CheckVehicleRealTime = CheckVehicleRealTime;
const dateFormat_util_1 = require("../utils/dateFormat.util");
const orm_util_1 = require("../utils/orm.util");
function CheckVehicleRealTime(uname_police, plate, user_id) {
    return __awaiter(this, void 0, void 0, function* () {
        //Check IN Redis DB if thisPlate Number Is Checked Before !
        yield (0, orm_util_1.executeNonQuery)('INSERT INTO inspected_vehicles (plate , police_id) VALUES(?,?);', [plate, user_id]);
        const currentTime = new Date();
        const isWantedVehcile = yield (0, orm_util_1.executeQuery)("SELECT COUNT(*) as 'wanted' FROM wanted_vehicle WHERE plate =?  ", [plate]);
        const isDriverWanted = yield (0, orm_util_1.executeQuery)(`SELECT
    p.criminal_status
FROM
    vehicle_license vl
JOIN driver_license dl ON
    vl.driving_license_id = dl.number
INNER JOIN person p ON
    p.national_id = dl.driver_id
WHERE
    vehicle_plate = ?;`, [plate]);
        const isVehcileHaveManyViolations = yield (0, orm_util_1.executeQuery)("SELECT SUM(vt.score) AS total FROM violations v JOIN violation_type vt ON v.type = vt.ID WHERE plate_id = ? AND status = 'unpaied';", [plate]);
        if (isWantedVehcile.data) {
            const wantedVehcile = isWantedVehcile.data[0].wanted;
            if (wantedVehcile > 0) {
                return {
                    plate,
                    status: 'مطلوبة',
                    timestamp: (0, dateFormat_util_1.getRealTime)(currentTime.toString()),
                };
            }
            if (isDriverWanted.data) {
                const driverWanted = isDriverWanted.data[0].criminal_status;
                if (driverWanted > 0) {
                    return {
                        plate,
                        status: 'مطارد',
                        timestamp: (0, dateFormat_util_1.getRealTime)(currentTime.toString()),
                    };
                }
                if (isVehcileHaveManyViolations.data) {
                    const HaveMenyViolation = isVehcileHaveManyViolations.data[0].total;
                    if (HaveMenyViolation > 50) {
                        // if SCORE > 50 then veh will BE WANTED
                        return {
                            plate,
                            status: 'مطلوبة',
                            timestamp: (0, dateFormat_util_1.getRealTime)(currentTime.toString()),
                        };
                    }
                }
            }
        }
        return {
            plate,
            status: 'سليمة',
            timestamp: (0, dateFormat_util_1.getRealTime)(currentTime.toString()),
        };
    });
}
