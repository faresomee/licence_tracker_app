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
exports.startServer = void 0;
const express_1 = __importDefault(require("express"));
const errorhandler_1 = __importDefault(require("errorhandler"));
const dotenv_1 = __importDefault(require("dotenv"));
const Database_1 = require("./database/Database");
const index_1 = __importDefault(require("./routes/index"));
const cors_1 = __importDefault(require("cors"));
const path_1 = __importDefault(require("path"));
const errorHandler_1 = require("./middleware/errorHandler");
const logger_1 = __importDefault(require("./utils/logger"));
const socket_io_1 = __importDefault(require("socket.io"));
const http_1 = __importDefault(require("http"));
const clients_1 = require("./utils/clients");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const aiModel_1 = require("./utils/aiModel");
const police_socket_1 = require("./controller/police.socket");
const orm_util_1 = require("./utils/orm.util");
const app = (0, express_1.default)();
app.use(express_1.default.json());
app.use((0, cors_1.default)());
app.use(express_1.default.static(path_1.default.join(__dirname, 'images')));
app.use('/uploads/images', express_1.default.static(path_1.default.join(__dirname, 'uploads', 'images')));
const httpserver = http_1.default.createServer(app);
const io = new socket_io_1.default.Server(httpserver, { cors: { origin: '*' } });
io.use((socket, next) => {
    var _a, _b;
    const token = ((_a = socket.handshake.auth) === null || _a === void 0 ? void 0 : _a.token) || ((_b = socket.handshake.query) === null || _b === void 0 ? void 0 : _b.token);
    if (!token) {
        next(new Error('Authentication token is required'));
        return;
    }
    const jwtSecret = process.env.JWT_SECRET || 'your-secret-key';
    if (!jwtSecret) {
        next(new Error('JWT secret is not defined'));
        return;
    }
    try {
        const userData = jsonwebtoken_1.default.verify(token, jwtSecret);
        socket.user = userData;
        if (typeof userData === 'object' &&
            userData !== null &&
            'username' in userData) {
            console.log('Welcome', userData.username);
        }
        else {
            console.log('Welcome, user');
        }
        next();
    }
    catch (err) {
        next(new Error('Invalid authentication token'));
    }
});
// SOCKET IO SERVER
io.on('connection', (socket) => __awaiter(void 0, void 0, void 0, function* () {
    const userData = socket.user;
    (0, clients_1.add)(socket);
    const query = 'UPDATE police_users SET online = 1 WHERE id = ?';
    yield (0, orm_util_1.executeNonQuery)(query, [userData.id]);
    socket.on('disconnect', () => __awaiter(void 0, void 0, void 0, function* () {
        (0, clients_1.remove)(socket);
        const query = 'UPDATE police_users SET online = 0 WHERE id = ?';
        yield (0, orm_util_1.executeNonQuery)(query, [userData.id]);
    }));
    socket.on('frame', (data) => __awaiter(void 0, void 0, void 0, function* () {
        const GetPlateNumber = yield (0, aiModel_1.SendDataToAIModel)(data);
        const ResponseData = yield (0, police_socket_1.CheckVehicleRealTime)(userData.username, GetPlateNumber, userData.id);
        socket.emit('frame', ResponseData);
    }));
}));
app.use((req, res, next) => {
    const startTime = new Date();
    res.on('finish', () => {
        const endTime = new Date();
        const responseTime = endTime.getTime() - startTime.getTime();
        const user = req.user;
        const logData = {
            method: req.method,
            url: req.baseUrl,
            status: res.statusCode,
            responseTime: `${responseTime}ms`,
            userAgent: req.get('user-agent'),
            ip: req.ip,
            user: (user === null || user === void 0 ? void 0 : user.name) || 'ADMIN',
        };
        if (req.method !== 'GET' && req.body && Object.keys(req.body).length > 0) {
            logData.requestBody = req.body;
        }
        if (req.query && Object.keys(req.query).length > 0) {
            logData.requestQuery = req.query;
        }
        if (req.params && Object.keys(req.params).length > 0) {
            logData.requestParams = req.params;
        }
        logger_1.default.http('HTTP Request', logData);
    });
    next();
});
dotenv_1.default.config();
app.get('/healthz', (_, response) => {
    response.status(200).send('server work');
});
if (process.env.NODE_ENV === 'development') {
    app.use((0, errorhandler_1.default)());
}
// ************** ROUTES ************** //
app.use(index_1.default);
app.use(errorHandler_1.errorHandler);
const startServer = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield (0, Database_1.StartConnectionToDb)();
        app.get('/isDbAlive', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
            try {
                const connection = yield (0, Database_1.getConnection)();
                const [rows] = yield connection.execute("SELECT 'Hello, World! FROM MYSQL' AS message");
                res.json(rows);
            }
            catch (error) {
                res.status(500).json({ error: 'Database connection failed' });
            }
        }));
        const port = process.env.PORT;
        httpserver.listen(port, () => {
            console.log('Server started on port', port);
        });
    }
    catch (error) {
        console.error('Failed to start server:', error);
        process.exit(1);
    }
});
exports.startServer = startServer;
