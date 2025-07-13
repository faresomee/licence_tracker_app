import express, { Response } from 'express'
import errorHandler from 'errorhandler'
import dotenv from 'dotenv'
import { getConnection, StartConnectionToDb } from './database/Database'
import mainRoute from './routes/index'
import cors from 'cors'
import path from 'path'
import { errorHandler as customErrorHandler } from './middleware/errorHandler'
import logger from './utils/logger'
import socketio from 'socket.io'
import http from 'http'
import { add, getClientCount, remove } from './utils/clients'
import jwt from 'jsonwebtoken'
import { SendDataToAIModel } from './utils/aiModel'
import { CheckVehicleRealTime } from './controller/police.socket'
import { executeNonQuery } from './utils/orm.util'
const app = express()

app.use(express.json())
app.use(cors())
app.use(express.static(path.join(__dirname, 'images')))

app.use(
  '/uploads/images',
  express.static(path.join(__dirname, 'uploads', 'images')),
)

const httpserver = http.createServer(app)
const io = new socketio.Server(httpserver, { cors: { origin: '*' } })

io.use((socket, next) => {
  const token = socket.handshake.auth?.token || socket.handshake.query?.token
  if (!token) {
    next(new Error('Authentication token is required'))
    return
  }
  const jwtSecret = process.env.JWT_SECRET || 'your-secret-key'
  if (!jwtSecret) {
    next(new Error('JWT secret is not defined'))
    return
  }
  try {
    const userData = jwt.verify(token, jwtSecret)
    ;(socket as any).user = userData
    if (
      typeof userData === 'object' &&
      userData !== null &&
      'username' in userData
    ) {
      console.log('Welcome', (userData as any).username)
    } else {
      console.log('Welcome, user')
    }
    next()
  } catch (err) {
    next(new Error('Invalid authentication token'))
  }
})

// SOCKET IO SERVER
io.on('connection', async (socket) => {
  const userData = (socket as any).user
  add(socket)

  const query = 'UPDATE police_users SET online = 1 WHERE id = ?'
  await executeNonQuery(query, [userData.id])

  socket.on('disconnect', async () => {
    remove(socket)
    const query = 'UPDATE police_users SET online = 0 WHERE id = ?'
    await executeNonQuery(query, [userData.id])
  })
  socket.on('frame', async (data) => {
    const GetPlateNumber: string = await SendDataToAIModel(data)
    const ResponseData = await CheckVehicleRealTime(
      userData.username,
      GetPlateNumber,
      userData.id,
    )
    socket.emit('frame', ResponseData)
  })
})

app.use((req, res, next) => {
  const startTime = new Date()
  res.on('finish', () => {
    const endTime = new Date()
    const responseTime = endTime.getTime() - startTime.getTime()

    interface LogData {
      method: string
      url: string
      status: number
      responseTime: string
      userAgent: string | undefined
      ip: string | undefined
      requestBody?: any
      requestQuery?: any
      requestParams?: any
      user?: string
    }
    const user = (req as any).user
    const logData: LogData = {
      method: req.method,
      url: req.baseUrl,
      status: res.statusCode,
      responseTime: `${responseTime}ms`,
      userAgent: req.get('user-agent'),
      ip: req.ip,
      user: user?.name || 'ADMIN',
    }

    if (req.method !== 'GET' && req.body && Object.keys(req.body).length > 0) {
      logData.requestBody = req.body
    }

    if (req.query && Object.keys(req.query).length > 0) {
      logData.requestQuery = req.query
    }

    if (req.params && Object.keys(req.params).length > 0) {
      logData.requestParams = req.params
    }

    logger.http('HTTP Request', logData)
  })

  next()
})

dotenv.config()

app.get('/healthz', (_, response: Response): void => {
  response.status(200).send('server work')
})

if (process.env.NODE_ENV === 'development') {
  app.use(errorHandler())
}

// ************** ROUTES ************** //

app.use(mainRoute)

app.use(customErrorHandler)

export const startServer = async () => {
  try {
    await StartConnectionToDb()
    app.get('/isDbAlive', async (req, res) => {
      try {
        const connection = await getConnection()
        const [rows] = await connection.execute(
          "SELECT 'Hello, World! FROM MYSQL' AS message",
        )
        res.json(rows)
      } catch (error) {
        res.status(500).json({ error: 'Database connection failed' })
      }
    })

    const port = process.env.PORT
    httpserver.listen(port, () => {
      console.log('Server started on port', port)
    })
  } catch (error) {
    console.error('Failed to start server:', error)
    process.exit(1)
  }
}
