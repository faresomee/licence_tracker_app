import multer from 'multer'
import path from 'path'
import crypto from 'crypto'
import { Request } from 'express'
import fs from 'fs'
import { promisify } from 'util'

const storage = multer.memoryStorage()

const fileFilter = (
  req: Request,
  file: Express.Multer.File,
  cb: multer.FileFilterCallback,
) => {
  if (file.mimetype.startsWith('image/')) {
    cb(null, true)
  } else {
    cb(new Error('Only image files are allowed'))
  }
}

const uploadMiddleware = multer({
  storage,
  fileFilter,
  limits: {
    fileSize: 50 * 1024 * 1024, // 50 MB
  },
})

export const uploadFile = uploadMiddleware.single('img_profile')
export const uploadMultiFiles = uploadMiddleware.array('attachment')

const getUploadDestination = (url: string): string => {
  console.log(url)
  if (url.includes('/police')) {
    return path.join(__dirname, '..', 'uploads', 'images', 'police_users')
  }
  if (url.includes('/admin')) {
    return path.join(__dirname, '..', 'uploads', 'images', 'admin_users')
  }
  if (url.includes('/violation')) {
    return path.join(__dirname, '..', 'uploads', 'images', 'violation_ticket')
  }
  if (url.includes('/custome/createViolation')) {
    return path.join(__dirname, '..', 'uploads', 'images', 'violation_ticket')
  }
  if (url.includes('/user/report')) {
    return path.join(__dirname, '..', 'uploads', 'images', 'user_report')
  }
  throw new Error('Invalid upload destination')
}

export const saveUploadedFile = async (req: Request): Promise<string> => {
  if (!req.file) {
    throw new Error('No file uploaded')
  }

  const filename =
    crypto.randomBytes(10).toString('hex') + path.extname(req.file.originalname)

  const destination = getUploadDestination(req.originalUrl)

  if (!fs.existsSync(destination)) {
    fs.mkdirSync(destination, { recursive: true })
  }

  const filePath = path.join(destination, filename)

  try {
    await promisify(fs.writeFile)(filePath, req.file.buffer)

    if (!fs.existsSync(filePath)) {
      throw new Error('File was not written successfully')
    }

    return filename
  } catch (error) {
    if (fs.existsSync(filePath)) {
      fs.unlinkSync(filePath) // clean up partial file
    }
    throw error
  }
}

export const saveUploadedFiles = async (req: Request): Promise<string[]> => {
  const files = req.files as Express.Multer.File[]

  if (!files || !Array.isArray(files) || files.length === 0) {
    throw new Error('No files uploaded')
  }

  const destination = getUploadDestination(req.originalUrl)

  if (!fs.existsSync(destination)) {
    fs.mkdirSync(destination, { recursive: true })
  }

  const savedFilenames: string[] = []

  for (const file of files) {
    const filename =
      crypto.randomBytes(10).toString('hex') + path.extname(file.originalname)
    const filePath = path.join(destination, filename)

    try {
      await promisify(fs.writeFile)(filePath, file.buffer)

      if (!fs.existsSync(filePath)) {
        throw new Error(`File ${file.originalname} was not saved successfully`)
      }

      savedFilenames.push(filename)
    } catch (error) {
      for (const f of savedFilenames) {
        const fullPath = path.join(destination, f)
        if (fs.existsSync(fullPath)) {
          fs.unlinkSync(fullPath)
        }
      }
      throw error
    }
  }

  return savedFilenames
}
