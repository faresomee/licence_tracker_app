"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getImageExtension = getImageExtension;
exports.getMonthKey = getMonthKey;
function getImageExtension(arrayBuffer) {
    const arr = new Uint8Array(arrayBuffer);
    if (arr[0] === 0x89 &&
        arr[1] === 0x50 &&
        arr[2] === 0x4e &&
        arr[3] === 0x47) {
        return 'png';
    }
    if (arr[0] === 0xff && arr[1] === 0xd8 && arr[2] === 0xff) {
        return 'jpg';
    }
    if (arr[0] === 0x47 && arr[1] === 0x49 && arr[2] === 0x46) {
        return 'gif';
    }
    if (arr[0] === 0x42 && arr[1] === 0x4d) {
        return 'bmp';
    }
    if (arr[0] === 0x52 &&
        arr[1] === 0x49 &&
        arr[2] === 0x46 &&
        arr[3] === 0x46 &&
        arr[8] === 0x57 &&
        arr[9] === 0x45 &&
        arr[10] === 0x42 &&
        arr[11] === 0x50) {
        return 'webp';
    }
    return 'bin';
}
function getMonthKey(digits) {
    const monthMap = {
        '01': 'janMonth',
        '02': 'febMonth',
        '03': 'marMonth',
        '04': 'aprMonth',
        '05': 'mayMonth',
        '06': 'junMonth',
        '07': 'julMonth',
        '08': 'augMonth',
        '09': 'sepMonth',
        '10': 'octMonth',
        '11': 'novMonth',
        '12': 'decMonth',
    };
    return monthMap[digits] || 'invalidMonth';
}
