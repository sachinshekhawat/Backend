const mongoose = require('mongoose');

const mongoURI = "mongodb+srv://Sachin:Krishna734@cluster0.gidnxoc.mongodb.net/"

const connectToMongo = async () => {
    await mongoose.connect(mongoURI);
    console.log("Connected to Mongo")
};


module.exports = connectToMongo;
