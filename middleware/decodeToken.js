const jwt = require('jsonwebtoken')
require("dotenv").config()
const JWT_SECRET = process.env.JWT_SECRET

const decodeToken = async (req, res, next) => {
    try {
        const token = req.header('auth-token')
        if (!token) throw { error: "Invalid Token" }
        const data = jwt.verify(token, JWT_SECRET)
        req.userId = data.User.id
        next()

    } catch (error) {
        return res.status(401).json({ sucess: false, "error": "INVALID TOKEN" })
    }


}


module.exports = decodeToken