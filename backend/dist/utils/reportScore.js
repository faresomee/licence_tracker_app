"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.reportScore = void 0;
const reportScore = (score) => {
    if (score <= 3) {
        return 'Low';
    }
    else if (score < 5) {
        return 'Moderate';
    }
    else {
        return 'Important';
    }
};
exports.reportScore = reportScore;
