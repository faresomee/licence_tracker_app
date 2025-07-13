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
exports.createVehicle = void 0;
const orm_util_1 = require("../utils/orm.util");
const errorHandler_1 = require("../middleware/errorHandler");
const createVehicle = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { Manufacturer, model, color, year } = req.body;
        const insertQuery = `
      INSERT INTO Vehicles (Manufacturer, model, color, year)
      VALUES (?, ?, ?, ?)
    `;
        const insertResult = yield (0, orm_util_1.executeNonQuery)(insertQuery, [
            Manufacturer,
            model,
            color,
            year,
        ]);
        if (!insertResult.success) {
            throw new Error('Failed to create vehicle');
        }
        const getQuery = `
      SELECT * FROM vehicles 
      WHERE id = LAST_INSERT_ID()
    `;
        const getResult = yield (0, orm_util_1.executeSingleQuery)(getQuery);
        if (!getResult.success || !getResult.data || getResult.data.length === 0) {
            throw new Error('Failed to retrieve created vehicle');
        }
        res.status(201).json({
            success: true,
            data: getResult.data[0],
        });
    }
    catch (error) {
        if (error instanceof errorHandler_1.ValidationError) {
            res.status(400).json({
                success: false,
                error: error.message,
            });
        }
        else {
            console.error('Error creating vehicle:', error);
            res.status(500).json({
                success: false,
                error: 'Internal server error',
            });
        }
    }
});
exports.createVehicle = createVehicle;
