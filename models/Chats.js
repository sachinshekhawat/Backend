const mongoose = require('mongoose')
const Schema = mongoose.Schema
const NotesSchema = new Schema({
    userFrom: {
        type: String,
        require: true
    },
    userTo: {
        type: String,
        require: true
    },
    data: {
        type: String,
        require: true
    },
    timestamp: {
        type: Date,
        default: Date
    }


});


module.exports = mongoose.model("Chat", NotesSchema); 