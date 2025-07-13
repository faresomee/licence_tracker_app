import { executeQuery } from './orm.util'

const generateOTP = (length: number = 4): string => {
  const characters = '0123456789'
  let otp = ''
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length)
    otp += characters[randomIndex]
  }
  return otp
}

const deleteExpiredOTP = async (userID: number): Promise<void> => {
  const deleteQuery = 'DELETE FROM sms_otp WHERE police_id = ?'
  await executeQuery(deleteQuery, [userID])
}

const checkOTPExists = async (
  userID: number,
  typeOfOTP: string,
): Promise<boolean> => {
  const query = `
        SELECT created_at 
        FROM sms_otp 
        WHERE police_id = ? 
          AND created_at >= NOW() - INTERVAL 5 MINUTE
          AND type = ?
        ORDER BY created_at DESC 
        LIMIT 1
    `
  const result = await executeQuery(query, [userID, typeOfOTP])

  if (!result.data || result.data.length === 0) {
    await deleteExpiredOTP(userID)
    return false
  }

  return true
}

export const sendOTP = async (
  phoneNumber: string,
  userID: number,
  typeOfOTP: string,
): Promise<void> => {
  const otpStillValid = await checkOTPExists(userID, typeOfOTP)

  if (otpStillValid) {
    console.log('OTP already sent and still valid. Try again later.')
    return
  }

  const otp = generateOTP(4)
  console.log('OTP ' + otp + ' SENT to ' + phoneNumber)
  if (typeOfOTP === 'login') {
    const insertQuery =
      'INSERT INTO sms_otp (otp, police_id,type) VALUES (?, ?,?)'
    await executeQuery(insertQuery, [otp, userID, 'login'])
  } else if (typeOfOTP === 'password') {
    const insertQuery =
      'INSERT INTO sms_otp (otp, police_id,type) VALUES (?, ?,?)'
    await executeQuery(insertQuery, [otp, userID, 'password'])
  }
}

export const getOTP = async (
  userID: number,
  typeOfOtp: string,
): Promise<number | null> => {
  const query = `
  SELECT otp 
  FROM sms_otp 
  WHERE police_id = ? AND type = ?
  ORDER BY created_at DESC
  LIMIT 1
`
  const result = await executeQuery(query, [userID, typeOfOtp])
  console.log('type of otp', typeOfOtp)
  console.log('otp FROM GET OTP METHOD', result)
  const data = result.data

  if (!data || data.length === 0) {
    return null
  }

  const otp = data[0].otp
  return otp || null
}
