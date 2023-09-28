const mongoose = require('mongoose')
const { Schema } = mongoose
const UserSchema = new Schema({
    name: {
        type: String,
        require: true
    },
    email: {
        type: String,
        require: true
    },
    password: {
        type: String,
        require: true
    },
    phone: {
        type: String,
        require: true,
    },
    picURL: {
        type: String,
        require: true,
        default: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
    }

});


module.exports = mongoose.model("User", UserSchema); 