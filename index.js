const connectToMongo = require("./db.js");
const express = require('express')
const bodyParser = require('body-parser')
const app = express()

// parse application/x-www-form-urlencode

// parse application/json
app.use(bodyParser.json())

// require("dotenv").config()
connectToMongo()
// var cors = require('cors')

// app.use(cors())

const PORT = process.env.PORT || 3000
app.use(express.json());
//Routes
app.use("/api/auth", require('./routes/auth.js'));
app.use("/api/chats", require('./routes/chats.js'));



app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
})