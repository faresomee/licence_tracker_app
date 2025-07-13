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
exports.executeQuery = executeQuery;
exports.executeSingleQuery = executeSingleQuery;
exports.executeNonQuery = executeNonQuery;
const Database_1 = require("../database/Database");
/**
 * Executes a MySQL query with parameters and returns the results
 * @param query - The SQL query string
 * @param params - Array of parameters to be used in the query
 * @returns Promise containing the query results or error information
 */
function executeQuery(query_1) {
    return __awaiter(this, arguments, void 0, function* (query, params = []) {
        try {
            const db = yield (0, Database_1.getConnection)();
            const [rows] = yield db.query(query, params);
            return {
                success: true,
                data: rows,
            };
        }
        catch (error) {
            console.error('Database query error:', error);
            return {
                success: false,
                error: error instanceof Error
                    ? error.message
                    : 'Unknown database error occurred',
            };
        }
    });
}
/**
 * Executes a MySQL query that returns a single row
 * @param query - The SQL query string
 * @param params - Array of parameters to be used in the query
 * @returns Promise containing the single row result or error information
 */
function executeSingleQuery(query_1) {
    return __awaiter(this, arguments, void 0, function* (query, params = []) {
        try {
            const db = yield (0, Database_1.getConnection)();
            const [rows] = yield db.query(query, params);
            const results = rows;
            return {
                success: true,
                data: results.length > 0 ? [results[0]] : [],
            };
        }
        catch (error) {
            console.error('Database query error:', error);
            return {
                success: false,
                error: error instanceof Error
                    ? error.message
                    : 'Unknown database error occurred',
            };
        }
    });
}
/**
 * Executes a MySQL query that doesn't return any rows (INSERT, UPDATE, DELETE)
 * @param query - The SQL query string
 * @param params - Array of parameters to be used in the query
 * @returns Promise containing the affected rows count or error information
 */
function executeNonQuery(query_1) {
    return __awaiter(this, arguments, void 0, function* (query, params = []) {
        try {
            const db = yield (0, Database_1.getConnection)();
            const [result] = yield db.query(query, params);
            return {
                success: true,
                affectedRows: result.affectedRows,
            };
        }
        catch (error) {
            console.error('Database query error:', error);
            return {
                success: false,
                error: error instanceof Error
                    ? error.message
                    : 'Unknown database error occurred',
            };
        }
    });
}
