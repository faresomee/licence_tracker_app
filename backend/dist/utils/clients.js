"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getClientCount = exports.getAllClients = exports.getClientById = exports.remove = exports.add = void 0;
let clients = {};
const add = (client) => {
    clients[client.id.toString()] = client;
};
exports.add = add;
const remove = (client) => {
    delete clients[client.id.toString()];
    return null;
};
exports.remove = remove;
const getClientById = (clientId) => {
    return clients[clientId];
};
exports.getClientById = getClientById;
const getAllClients = () => {
    return clients;
};
exports.getAllClients = getAllClients;
const getClientCount = () => {
    return Object.keys(clients).length;
};
exports.getClientCount = getClientCount;
