import dayjs from 'dayjs'
import 'dayjs/locale/ar'
import advancedFormat from 'dayjs/plugin/advancedFormat'

dayjs.extend(advancedFormat)
dayjs.locale('ar')

export const formatDate = (dateString: string): string => {
  return dayjs(dateString).format('D MMMM YYYY')
}

export const formatDateV2 = (dateString: string): string => {
  return dayjs(dateString).format('DD/MM/YYYY')
}

export const getHouers = (dateString: string): string => {
  return dayjs(dateString).format('HH:mm')
}

export const getRealTime = (dateString: string): string => {
  return dayjs(dateString).format('HH:mm:ss')
}

export const getFullDate = (dateString: string): string => {
  return dayjs(dateString).format('YYYY-MM-DD (HH:mm)')
}

export const validDate = (dateString: Date): string => {
  const currentDate = new Date()
  const inputDate = new Date(dateString)
  if (inputDate < currentDate) {
    return 'expired'
  }
  return 'valid'
}
