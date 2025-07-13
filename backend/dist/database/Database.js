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
exports.getConnection = exports.StartConnectionToDb = void 0;
const promise_1 = __importDefault(require("mysql2/promise"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
class Database {
    constructor() { }
    static getInstance() {
        if (!Database.instance) {
            Database.instance = new Database();
        }
        return Database.instance;
    }
    connect() {
        return __awaiter(this, void 0, void 0, function* () {
            if (!this.connection) {
                try {
                    this.connection = yield promise_1.default.createConnection({
                        host: process.env.MYSQL_HOST || 'localhost',
                        user: process.env.MYSQL_USER || 'root',
                        password: process.env.MYSQL_PASSWORD || '',
                        database: process.env.MYSQL_DBNAME || 'test_db',
                        port: Number(process.env.MYSQL_PORT) || 3306,
                    });
                    console.log('Connected To MySQL Successfully!');
                }
                catch (error) {
                    console.error('Connection Failed:', error);
                    process.exit(1);
                }
            }
        });
    }
    getConnection() {
        if (!this.connection) {
            throw new Error('Database not connected Call it first.');
        }
        return this.connection;
    }
}
const databaseInstance = Database.getInstance();
const StartConnectionToDb = () => __awaiter(void 0, void 0, void 0, function* () {
    yield databaseInstance.connect();
});
exports.StartConnectionToDb = StartConnectionToDb;
const getConnection = () => __awaiter(void 0, void 0, void 0, function* () {
    return databaseInstance.getConnection();
});
exports.getConnection = getConnection;
exports.default = Database;
