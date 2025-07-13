import { getConnection } from '../database/Database'
import { RowDataPacket } from 'mysql2'

interface QueryResult<T> {
  success: boolean
  data?: T[]
  error?: string
}

/**
 * Executes a MySQL query with parameters and returns the results
 * @param query - The SQL query string
 * @param params - Array of parameters to be used in the query
 * @returns Promise containing the query results or error information
 */

export async function executeQuery<T extends RowDataPacket>(
  query: string,
  params: any[] = [],
): Promise<QueryResult<T>> {
  try {
    const db = await getConnection()
    const [rows] = await db.query(query, params)
    return {
      success: true,
      data: rows as T[],
    }
  } catch (error) {
    console.error('Database query error:', error)
    return {
      success: false,
      error:
        error instanceof Error
          ? error.message
          : 'Unknown database error occurred',
    }
  }
}

/**
 * Executes a MySQL query that returns a single row
 * @param query - The SQL query string
 * @param params - Array of parameters to be used in the query
 * @returns Promise containing the single row result or error information
 */
export async function executeSingleQuery<T extends RowDataPacket>(
  query: string,
  params: any[] = [],
): Promise<QueryResult<T>> {
  try {
    const db = await getConnection()
    const [rows] = await db.query(query, params)
    const results = rows as T[]
    return {
      success: true,
      data: results.length > 0 ? [results[0]] : [],
    }
  } catch (error) {
    console.error('Database query error:', error)
    return {
      success: false,
      error:
        error instanceof Error
          ? error.message
          : 'Unknown database error occurred',
    }
  }
}

/**
 * Executes a MySQL query that doesn't return any rows (INSERT, UPDATE, DELETE)
 * @param query - The SQL query string
 * @param params - Array of parameters to be used in the query
 * @returns Promise containing the affected rows count or error information
 */
export async function executeNonQuery(
  query: string,
  params: any[] = [],
): Promise<{ success: boolean; affectedRows?: number; error?: string }> {
  try {
    const db = await getConnection()
    const [result] = await db.query(query, params)
    return {
      success: true,
      affectedRows: (result as any).affectedRows,
    }
  } catch (error) {
    console.error('Database query error:', error)
    return {
      success: false,
      error:
        error instanceof Error
          ? error.message
          : 'Unknown database error occurred',
    }
  }
}
