import asyncHandler from '../middleware/asyncHandler'
import { Request, Response } from 'express'
import { executeQuery } from '../utils/orm.util'
import { RowDataPacket } from 'mysql2'
import { getMonthKey } from '../utils/DevOperation'
import { HandelStatistics } from '../utils/response'

export interface HomePage extends RowDataPacket {
  Total_Violations: number
  detected_violation: number
  under_investigation: number
}
export const getStatsitcsOfHome = asyncHandler(
  async (req: Request, res: Response) => {
    const query = `SELECT
  (SELECT COUNT(*) FROM violations WHERE created_at >= NOW() - INTERVAL 30 DAY) AS Total_Violations,
  (SELECT COUNT(*) FROM violations WHERE status = 'paied' AND created_at >= NOW() - INTERVAL 30 DAY) AS detected_violation,
  (SELECT COUNT(*) FROM violations WHERE status = 'under_review' OR status = 'unpaied' AND created_at >= NOW() - INTERVAL 30 DAY) AS under_investigation;
`
    const secondQuery = `WITH last_6_months AS (
  SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m') AS month
  FROM (
    SELECT 0 AS n UNION ALL
    SELECT 1 UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 UNION ALL
    SELECT 5
  ) AS months
),
violation_counts AS (
  SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(*) AS total_violations
  FROM violations
  WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
  GROUP BY DATE_FORMAT(created_at, '%Y-%m')
)
SELECT
  m.month,
  COALESCE(v.total_violations, 0) AS total_violations
FROM last_6_months m
LEFT JOIN violation_counts v ON m.month = v.month
ORDER BY m.month DESC;`

    const userStaticQuery = `-- Query to get monthly statistics for user_report and user_objections
-- Returns correct (accepted + resolved) and false (rejected + rejected) counts for last 6 months

WITH months AS (
    SELECT 
        DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m') as month_key,
        DATE_SUB(CURDATE(), INTERVAL n MONTH) as month_date,
        n + 1 as month_order
    FROM (
        SELECT 0 as n UNION ALL SELECT 1 UNION ALL SELECT 2 
        UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    ) numbers
),

report_stats AS (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') as month_key,
        SUM(CASE WHEN status = 'accepted' THEN 1 ELSE 0 END) as accepted_count,
        SUM(CASE WHEN status = 'rejected' THEN 1 ELSE 0 END) as rejected_count
    FROM user_report 
    WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
),

objection_stats AS (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') as month_key,
        SUM(CASE WHEN status = 'resolved' THEN 1 ELSE 0 END) as resolved_count,
        SUM(CASE WHEN status = 'rejected' THEN 1 ELSE 0 END) as rejected_count
    FROM user_objections 
    WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
),

combined_stats AS (
    SELECT 
        m.month_key,
        m.month_order,
        COALESCE(r.accepted_count, 0) + COALESCE(o.resolved_count, 0) as correct_count,
        COALESCE(r.rejected_count, 0) + COALESCE(o.rejected_count, 0) as false_count
    FROM months m
    LEFT JOIN report_stats r ON m.month_key = r.month_key
    LEFT JOIN objection_stats o ON m.month_key = o.month_key
    ORDER BY m.month_order DESC
)

SELECT 
    CONCAT('[', GROUP_CONCAT(correct_count ORDER BY month_order DESC SEPARATOR ','), ']') as correct_array,
    CONCAT('[', GROUP_CONCAT(false_count ORDER BY month_order DESC SEPARATOR ','), ']') as false_array
FROM combined_stats;`
    const data = await executeQuery<HomePage>(query, [])
    const fethced_trend = await executeQuery(secondQuery, [])
    const UserData = await executeQuery(userStaticQuery, [])
    let detected_violation = 0
    let undetected_violation = 0
    let FetchedData
    let lineChart
    if (fethced_trend && fethced_trend.data) {
      lineChart = fethced_trend.data
    }
    if (data && data.data) {
      FetchedData = data.data[0]
      detected_violation = data.data[0].detected_violation
      undetected_violation = data.data[0].under_investigation
    }
    lineChart = lineChart?.map((el) => {
      return {
        ...el,
        month: getMonthKey(el.month.split('-')[1]),
      }
    })
    let correct_data
    let false_data
    if (UserData && UserData.data) {
      correct_data = UserData.data[0].correct_array
      false_data = UserData.data[0].false_array
    }
    res.status(200).json({
      sucess: true,
      statsticsData: HandelStatistics(FetchedData),
      barData: {
        correct: JSON.parse(correct_data),
        false: JSON.parse(false_data),
      }, // Not Completed
      pieDate: [detected_violation, undetected_violation],
      lineChart,
    })
  },
)
