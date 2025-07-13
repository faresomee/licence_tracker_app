import { Socket } from 'socket.io'

interface ClientMap {
  [key: string]: Socket
}

let clients: ClientMap = {}

export const add = (client: Socket) => {
  clients[client.id.toString()] = client
}

export const remove = (client: Socket) => {
  delete clients[client.id.toString()]
  return null
}

export const getClientById = (clientId: string): Socket | undefined => {
  return clients[clientId]
}

export const getAllClients = (): ClientMap => {
  return clients
}

export const getClientCount = (): number => {
  return Object.keys(clients).length
}
