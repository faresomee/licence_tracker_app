import mysql, { Connection } from 'mysql2/promise'
import dotenv from 'dotenv'

dotenv.config()
class Database {
  private static instance: Database
  private connection!: Connection

  private constructor() {}

  public static getInstance(): Database {
    if (!Database.instance) {
      Database.instance = new Database()
    }
    return Database.instance
  }

  public async connect() {
    if (!this.connection) {
      try {
        this.connection = await mysql.createConnection({
          host: process.env.MYSQL_HOST || 'localhost',
          user: process.env.MYSQL_USER || 'root',
          password: process.env.MYSQL_PASSWORD || '',
          database: process.env.MYSQL_DBNAME || 'test_db',
          port: Number(process.env.MYSQL_PORT) || 3306,
        })

        console.log('Connected To MySQL Successfully!')
      } catch (error) {
        console.error('Connection Failed:', error)
        process.exit(1)
      }
    }
  }

  public getConnection(): Connection {
    if (!this.connection) {
      throw new Error('Database not connected Call it first.')
    }
    return this.connection
  }
}

const databaseInstance = Database.getInstance()

const StartConnectionToDb = async () => {
  await databaseInstance.connect()
}

const getConnection = async (): Promise<Connection> => {
  return databaseInstance.getConnection()
}

export { StartConnectionToDb, getConnection }

export default Database
