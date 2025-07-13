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
exports.HandelStatistics = exports.HandelAttachmets = exports.HandelViolations = exports.generateActivitesCard = exports.generateUrgentCard = exports.generateDescriptionForNotification = void 0;
const dateFormat_util_1 = require("./dateFormat.util");
const orm_util_1 = require("./orm.util");
const generateDescriptionForNotification = (typeOfNotification, reportId = null) => {
    if (typeOfNotification === 'password change') {
        return 'تم تحديث كلمة المرور,يرجى تذكرها';
    }
    else if (typeOfNotification === 'report') {
        return 'تم الرد على آخر تقرير لك، الرجاء المتابعة.';
    }
};
exports.generateDescriptionForNotification = generateDescriptionForNotification;
const generateUrgentCard = (vehicle, person) => {
    if (person && vehicle) {
        const v = vehicle[0];
        const p = person[0];
        if (v && p) {
            return {
                vehicle_card: {
                    urgentName: 'مركبة مطلوبة',
                    palteNumber: 'رقم اللوحة ' + v.plate,
                    description: `${v.classification} ${v.type} ${v.name} - مطلوبة `,
                    time: (0, dateFormat_util_1.getHouers)(v.created_at),
                },
                person_card: {
                    urgentName: 'شخص مطلوب',
                    national_id: 'الرقم القومي: ' + p.national_id,
                    criminal_status: p.criminal_status === 1 ? 'مطلوب' : 'غير مطلوب',
                    description: 'مطلوب أمنيًا ويجري البحث عنه.',
                    time: (0, dateFormat_util_1.getHouers)(p.changed),
                },
            };
        }
        else if (v && !p) {
            return {
                vehicle_card: {
                    urgentName: 'مركبة مطلوبة',
                    palteNumber: 'رقم اللوحة ' + v.plate,
                    description: `${v.classification} ${v.type} ${v.name} - مطلوبة `,
                    time: (0, dateFormat_util_1.getHouers)(v.created_at),
                },
            };
        }
        else {
            return {
                person_card: {
                    urgentName: 'شخص مطلوب',
                    national_id: 'الرقم القومي: ' + p.national_id,
                    criminal_status: p.criminal_status === 1 ? 'مطلوب' : 'غير مطلوب',
                    description: 'مطلوب أمنيًا ويجري البحث عنه.',
                    time: (0, dateFormat_util_1.getHouers)(p.changed),
                },
            };
        }
    }
};
exports.generateUrgentCard = generateUrgentCard;
const generateActivitesCard = (ticket, check, wanted_vehicle) => {
    if (ticket && check) {
        const t = ticket[0];
        const v = check[0];
        const w = wanted_vehicle ? wanted_vehicle[0] : undefined;
        if (!v && !w) {
            return {
                activites_card: {
                    ticket: 'مخالفة ' + t.violation_type,
                    description: t.plate + t.vehicle_name,
                    action: t.violation_action,
                    time: (0, dateFormat_util_1.getHouers)(t.create_at),
                },
                inspected: {},
            };
        }
        return {
            activites_card: {
                ticket: 'مخالفة ' + t.violation_type,
                description: t.plate + t.vehicle_name,
                action: t.violation_action,
                time: (0, dateFormat_util_1.getHouers)(t.create_at),
            },
            inspected: {
                type: 'فحص روتيني',
                vehicle_name: v.name + ' ' + v.plate,
                status: w === undefined ? 'سليمة' : 'مطلوبة',
                time: (0, dateFormat_util_1.getHouers)(v.create_at),
            },
        };
    }
    else {
        return {};
    }
};
exports.generateActivitesCard = generateActivitesCard;
const formatViolations = (violations) => {
    const list = Array.isArray(violations) ? violations : [violations];
    let caseSolved = 0;
    let activeCase = 0;
    let pendingCase = 0;
    for (const vio of list) {
        switch (vio.violation_status) {
            case 'paied':
                ++caseSolved;
                break;
            case 'unpaied':
                ++activeCase;
                break;
            case 'under_review':
                ++pendingCase;
                break;
        }
    }
    return {
        caseSolved,
        activeCase,
        pendingCase,
    };
};
const HandelViolations = (policeData) => __awaiter(void 0, void 0, void 0, function* () {
    const police_id = policeData.id;
    const spesific_violations = yield (0, orm_util_1.executeQuery)(`
SELECT 
  v.plate_id as plate_number ,
  v.location as location ,
  vt.name as violation ,
  v.status as violation_status ,
  v.id as violation_id
FROM violations v 
INNER JOIN violation_type vt ON vt.ID = v.type
WHERE v.police_id = ?`, [police_id]);
    if (spesific_violations && spesific_violations.data) {
        const statstic_data = formatViolations(spesific_violations.data);
        return {
            sucess: true,
            statistics: statstic_data,
            total: spesific_violations.data.length,
            data: spesific_violations.data,
        };
    }
    else {
        return {
            sucess: false,
            total: 0,
            data: {},
        };
    }
});
exports.HandelViolations = HandelViolations;
const HandelAttachmets = (attachments, protocol, host, fileName) => {
    const baseUrl = `${protocol}://${host}/uploads/images/${fileName || 'violation_ticket'}/`;
    if (!attachments)
        return [];
    let files = [];
    if (typeof attachments === 'string') {
        try {
            files = JSON.parse(attachments);
            if (!Array.isArray(files)) {
                files = attachments.split(',');
            }
        }
        catch (_a) {
            files = attachments.split(',');
        }
    }
    else if (Array.isArray(attachments)) {
        files = attachments;
    }
    return files.map((file) => baseUrl + file.trim());
};
exports.HandelAttachmets = HandelAttachmets;
const HandelStatistics = (items) => {
    let Total_Violations = (items === null || items === void 0 ? void 0 : items.Total_Violations) || 0;
    let detected_violation = (items === null || items === void 0 ? void 0 : items.detected_violation) || 0;
    let under_investigation = (items === null || items === void 0 ? void 0 : items.under_investigation) || 0;
    return {
        Total_Violations,
        detected_violation,
        under_investigation,
    };
};
exports.HandelStatistics = HandelStatistics;
