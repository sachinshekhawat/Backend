//Express
const express = require("express")
const router = express.Router()

//Bcrypt

require("dotenv").config()

const User = require('../models/User')



//CreateUser ROUTE
router.post('/createUser',

    async (req, res) => {


        try {
            let user = await User.findOne({ email: req.body.email })
            if (user) {
                console.log(user)
                return res.status(400).json({ sucess: false, "error": "Email in already exists" })
            }
            user = new User(
                {
                    name: req.body.name,
                    email: req.body.email,
                    phone: req.body.phone,
                    password: req.body.password
                })
            await user.save()

            res.json({ sucess: true, user })


        } catch (err) {
            return res.status(500).json({ sucess: false, err })
        }
    })

//Login ROUTE

router.post('/login', [


],

    async (req, res) => {

        try {


            let user = await User.findOne({ email: req.body.email })
            if (!user) {
                return res.status(400).json({ sucess: false, error: "Invalid credentials" })
            }

            if (req.body.password != user.password) {
                return res.status(400).json({ sucess: false, error: "Invalid credentials" })
            }

            res.json({ sucess: true, user })


        } catch (err) {
            return res.status(500).json({ sucess: false, err })
        }

    })

//GetUser ROUTE
router.get('/getusers', async (req, res) => {
    try {
        const users = await User.find({})
        // console.log(users)
        return res.json({ sucess: true, users })
    } catch (error) {
        return res.status(500).json({ sucess: false, error })
    }
})


router.put('/updatePic', async (req, res) => {
    try {
        const user = await User.findOneAndUpdate({ email: req.body.email }, { picURL: req.body.picURL })
        if (!user) return res.status(404).json({ success: false, error: "No email registered" })
        return res.json({ sucess: true, user })
    } catch (error) {
        return res.status(500).json({ sucess: false, error })
    }
})


module.exports = router