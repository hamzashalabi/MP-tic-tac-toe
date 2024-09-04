const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require('./models/room');

const app = express();
const port = process.env.PORT || 3000;

const server = http.createServer(app);
const io = require("socket.io")(server);

io.on('connection', (socket) => {
    console.log("connection io success");
    socket.on("createRoom", async ({ nickName }) => {
        console.log(nickName);
        try {
            let room = new Room;
            let player = {
                socketId: socket.id,
                nickName: nickName,
                playerType: 'X',
            };

            room.players.push(player);
            room.turn = player;

            room = await room.save();
            const roomId = room._id.toString();
            socket.join(roomId);
            io.to(roomId).emit('createRoomSuccess', room);
        } catch (e) {
            console.log(e);
        }
    });
});

app.use(express.json());

const DB = "mongodb+srv://hamzashalabi:hamza153@cluster0.xtqhi.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

mongoose.connect(DB).then(() => {
    console.log("connection successful");

}).catch((e) => {
    console.log(e);
});

server.listen(port, "0.0.0.0", () => {
    console.log(`server is created and running on port ${port}`);
});
