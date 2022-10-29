/* eslint-disable no-empty */
/* eslint-disable no-undef */
require("dotenv").config();
const http = require('http');
const express = require("express");
const app = express();
const customHttpServer = http.createServer(app);
const io = require('socket.io')(customHttpServer, {
    cors: {
        origin: '*'
    }
});
io.on('connection', (socket) => {
    console.log(`${socket.id} has been added to the socket connection`);
});
const userPoints = require("./src/models/UserPoints");
const Module = require("./src/models/Module");

const Users = require("./src/models/users");
const fs = require("fs");

const PORT = process.env.PORT || 4000;
const ObjectId = require("mongoose").Types.ObjectId;

//startup section

require("./src/startup")(app);
const init_db = require("./src/db");

const db_init = async () => await init_db();
db_init();

// let server = 
customHttpServer.listen(PORT, () => 
 console.log("Server listening on port " + PORT)

);

customHttpServer.setTimeout(2 * 60 * 1000);
