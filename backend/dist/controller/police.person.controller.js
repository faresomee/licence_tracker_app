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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getLicnseByID = void 0;
const asyncHandler_1 = __importDefault(require("../middleware/asyncHandler"));
const orm_util_1 = require("../utils/orm.util");
const dateFormat_util_1 = require("../utils/dateFormat.util");
exports.getLicnseByID = (0, asyncHandler_1.default)((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const { id } = req.params;
    const query = `SELECT
    vl.color AS "Vehicle_color",
    p.full_name AS "Person_full_name",
    p.address AS "Person_address",
    vl.vehicle_plate AS "Plate_Number",
    vl.type AS "Vehicle_license_type",
    vl.inspection_date AS "Vehicle_inspection_date",
    veh.brand AS "Vehicle_brand",
    veh.type AS "Vehicle_body_type",
    veh.classification AS "Vehicle_classification",
    veh.name AS "Vehicle_name",
    veh.model AS "Vehicle_model",
    dl.driver_id AS "Person_national_id",
    lt.type_name AS "Driving_license_type",
    dl.education AS "Person_education",
    dl.nationality AS "Person_nationality",
    dl.number AS "Driving_license_id",
    dl.issue_date,
    dl.expiry_date,
    dl.traffic_department,
    dl.traffic_office
FROM
    vehicle_license AS vl
INNER JOIN vehicle AS veh
    ON veh.plate = vl.vehicle_plate
INNER JOIN driver_license AS dl
    ON dl.number = vl.driving_license_id
INNER JOIN license_types AS lt
    ON lt.code = dl.type
INNER JOIN person AS p 
    ON p.national_id = dl.driver_id
WHERE
    vl.driving_license_id = ?;`;
    const person = yield (0, orm_util_1.executeQuery)(query, [id]);
    if (((_a = person.data) === null || _a === void 0 ? void 0 : _a.length) === 0) {
        res
            .status(404)
            .json({ message: 'لم يتم العثور على بيانات الرخصة المطلوبة.' });
    }
    const personData = person.data
        ? person.data.map((person) => {
            return {
                person: {
                    id: person.Person_national_id,
                    name: person.Person_full_name,
                    address: person.Person_address,
                    education: person.Person_education,
                    nationality: person.Person_nationality,
                },
                vehicle: {
                    classification: person.Vehicle_type,
                    plate: person.Plate_Number,
                    name: person.Vehicle_name, //
                    model: person.Vehicle_model,
                    color: person.Vehicle_color,
                    brand: person.Vehicle_brand,
                    type: person.type_of_vehicle_license,
                },
                license: {
                    id: person.Driving_license_id,
                    valid: (0, dateFormat_util_1.validDate)(person.expiry_date),
                    type: person.Vehicle_license_type,
                    traffic_department: person.traffic_department,
                    traffic_office: person.traffic_office,
                    issue_date: (0, dateFormat_util_1.formatDateV2)(person.issue_date),
                    expiry_date: (0, dateFormat_util_1.formatDateV2)(person.expiry_date),
                    inspection_date: (0, dateFormat_util_1.formatDateV2)(person.Vehicle_inspection_date),
                },
            };
        })
        : [];
    res.status(200).json({ information: personData });
}));
