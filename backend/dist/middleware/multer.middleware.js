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
exports.saveUploadedFiles = exports.saveUploadedFile = exports.uploadMultiFiles = exports.uploadFile = void 0;
const multer_1 = __importDefault(require("multer"));
const path_1 = __importDefault(require("path"));
const crypto_1 = __importDefault(require("crypto"));
const fs_1 = __importDefault(require("fs"));
const util_1 = require("util");
const storage = multer_1.default.memoryStorage();
const fileFilter = (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) {
        cb(null, true);
    }
    else {
        cb(new Error('Only image files are allowed'));
    }
};
const uploadMiddleware = (0, multer_1.default)({
    storage,
    fileFilter,
    limits: {
        fileSize: 50 * 1024 * 1024, // 50 MB
    },
});
exports.uploadFile = uploadMiddleware.single('img_profile');
exports.uploadMultiFiles = uploadMiddleware.array('attachment');
const getUploadDestination = (url) => {
    console.log(url);
    if (url.includes('/police')) {
        return path_1.default.join(__dirname, '..', 'uploads', 'images', 'police_users');
    }
    if (url.includes('/admin')) {
        return path_1.default.join(__dirname, '..', 'uploads', 'images', 'admin_users');
    }
    if (url.includes('/violation')) {
        return path_1.default.join(__dirname, '..', 'uploads', 'images', 'violation_ticket');
    }
    if (url.includes('/custome/createViolation')) {
        return path_1.default.join(__dirname, '..', 'uploads', 'images', 'violation_ticket');
    }
    if (url.includes('/user/report')) {
        return path_1.default.join(__dirname, '..', 'uploads', 'images', 'user_report');
    }
    throw new Error('Invalid upload destination');
};
const saveUploadedFile = (req) => __awaiter(void 0, void 0, void 0, function* () {
    if (!req.file) {
        throw new Error('No file uploaded');
    }
    const filename = crypto_1.default.randomBytes(10).toString('hex') + path_1.default.extname(req.file.originalname);
    const destination = getUploadDestination(req.originalUrl);
    if (!fs_1.default.existsSync(destination)) {
        fs_1.default.mkdirSync(destination, { recursive: true });
    }
    const filePath = path_1.default.join(destination, filename);
    try {
        yield (0, util_1.promisify)(fs_1.default.writeFile)(filePath, req.file.buffer);
        if (!fs_1.default.existsSync(filePath)) {
            throw new Error('File was not written successfully');
        }
        return filename;
    }
    catch (error) {
        if (fs_1.default.existsSync(filePath)) {
            fs_1.default.unlinkSync(filePath); // clean up partial file
        }
        throw error;
    }
});
exports.saveUploadedFile = saveUploadedFile;
const saveUploadedFiles = (req) => __awaiter(void 0, void 0, void 0, function* () {
    const files = req.files;
    if (!files || !Array.isArray(files) || files.length === 0) {
        throw new Error('No files uploaded');
    }
    const destination = getUploadDestination(req.originalUrl);
    if (!fs_1.default.existsSync(destination)) {
        fs_1.default.mkdirSync(destination, { recursive: true });
    }
    const savedFilenames = [];
    for (const file of files) {
        const filename = crypto_1.default.randomBytes(10).toString('hex') + path_1.default.extname(file.originalname);
        const filePath = path_1.default.join(destination, filename);
        try {
            yield (0, util_1.promisify)(fs_1.default.writeFile)(filePath, file.buffer);
            if (!fs_1.default.existsSync(filePath)) {
                throw new Error(`File ${file.originalname} was not saved successfully`);
            }
            savedFilenames.push(filename);
        }
        catch (error) {
            for (const f of savedFilenames) {
                const fullPath = path_1.default.join(destination, f);
                if (fs_1.default.existsSync(fullPath)) {
                    fs_1.default.unlinkSync(fullPath);
                }
            }
            throw error;
        }
    }
    return savedFilenames;
});
exports.saveUploadedFiles = saveUploadedFiles;
