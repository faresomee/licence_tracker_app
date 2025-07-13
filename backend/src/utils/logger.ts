import winston, { transport } from 'winston'
import Transport from 'winston-transport'
import { getConnection } from '../database/Database'

class MySQLTransport extends Transport {
  constructor(opts?: transport.TransportStreamOptions) {
    super(opts)
  }

  async log(info: any, callback: () => void) {
    setImmediate(() => {
      this.emit('logged', info)
    })

    try {
      const connection = await getConnection()
      const { level, message, ...meta } = info

      await connection.execute(
        'INSERT INTO AuditLogs (level, message, meta) VALUES (?, ?, ?)',
        [level, message, JSON.stringify(meta)],
      )

      callback()
    } catch (error) {
      console.error('Failed to log to MySQL:', error)
      callback()
    }
  }
}

const levels = {
  http: 0,
}

const colors = {
  http: 'green',
}

winston.addColors(colors)

const format = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss:ms' }),
  winston.format.colorize({ all: true }),
  winston.format.printf(
    (info) => `${info.timestamp} ${info.level}: ${info.message}`,
  ),
)

const logger = winston.createLogger({
  level: 'http',
  levels,
  format,
  transports: [new winston.transports.Console(), new MySQLTransport()],
})

export default logger
