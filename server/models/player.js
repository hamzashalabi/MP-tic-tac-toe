const mongoose = require("mongoose");

const playerSchema = new mongoose.Schema({
    nickName: {
        type: String,
        trim: true,
    },
    socketId: {
        type: String,
    },
    points: {
        type: Number,
        default: 0,
    },
    playerType: {
        requird: true,
        type: String,
    },
});
module.exports = playerSchema;