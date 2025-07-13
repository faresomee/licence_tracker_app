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
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const winston_1 = __importDefault(require("winston"));
const winston_transport_1 = __importDefault(require("winston-transport"));
const Database_1 = require("../database/Database");
class MySQLTransport extends winston_transport_1.default {
    constructor(opts) {
        super(opts);
    }
    log(info, callback) {
        return __awaiter(this, void 0, void 0, function* () {
            setImmediate(() => {
                this.emit('logged', info);
            });
            try {
                const connection = yield (0, Database_1.getConnection)();
                const { level, message } = info, meta = __rest(info, ["level", "message"]);
                yield connection.execute('INSERT INTO AuditLogs (level, message, meta) VALUES (?, ?, ?)', [level, message, JSON.stringify(meta)]);
                callback();
            }
            catch (error) {
                console.error('Failed to log to MySQL:', error);
                callback();
            }
        });
    }
}
const levels = {
    http: 0,
};
const colors = {
    http: 'green',
};
winston_1.default.addColors(colors);
const format = winston_1.default.format.combine(winston_1.default.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss:ms' }), winston_1.default.format.colorize({ all: true }), winston_1.default.format.printf((info) => `${info.timestamp} ${info.level}: ${info.message}`));
const logger = winston_1.default.createLogger({
    level: 'http',
    levels,
    format,
    transports: [new winston_1.default.transports.Console(), new MySQLTransport()],
});
exports.default = logger;
