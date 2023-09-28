//Express Package
const express = require('express')
const router = express.Router();
const bodyParser = require('body-parser');

//Note Model
const Chat = require('../models/Chats')

//Decode Token 
// const decodeToken = require('../middleware/decodeToken');


router.use(bodyParser.json())
router.get('/getChats', async (req, res) => {
    try {

        // console.log(req.body.user1)
        const chats = await Chat.find({ userFrom: req.body.user1, userTo: req.body.user2 })
        // await chats.append(Chat.find({ userFrom: req.body.user2, userTo: req.body.user1 }))
        // console.log(chats)

        if (!chats) {
            return res.status(404).send("No Chats")
        }
        res.json(chats)
    } catch (err) {
        return res.status(500).send("Internal Error")
    }
})

//Add note ROUTE 2: Login

router.post('/addChat',
    async (req, res) => {

        try {

            // console.log(req.body.description)
            let chat = new Chat({
                userFrom: req.userFrom,
                userTo: req.body.userTo,
                data: req.body.data
            })
            chat.userFrom = req.body.userFrom
            // console.log(req.body)
            await chat.save()
            // console.log(chat)
            res.json(chat)
        } catch (err) {
            // console.log(err)
            return res.status(500).send("Internal Error")
        }
    })

//Update Note ROUTE 3 : Login
// router.put('/updatenote/:id', decodeToken, async (req, res) => {


//     try {
//         let note = await Note.findById(req.params.id)
//         if (!note) {
//             return res.send("No note")
//         }
//         if (note.userId.toString() != req.userId) {
//             return res.send("No Autherization")
//         }
//         let newNote = {}

//         const { title, description, tag } = req.body

//         if (title) newNote.title = title
//         if (description) newNote.description = description
//         if (tag) newNote.tag = tag

//         note = await Note.findByIdAndUpdate(req.params.id, newNote)

//         res.json(note)
//     } catch (err) {
//         return res.status(500).send(err)
//     }
// })

// //Delete Note ROUTE 4 Login
// router.delete('/deletenote/:id', decodeToken, async (req, res) => {


//     try {
//         let note = await Note.findById(req.params.id)
//         if (!note) {
//             return res.send("No note")
//         }
//         if (note.userId.toString() != req.userId) {
//             return res.send("No Autherization")
//         }


//         await Note.findByIdAndDelete(req.params.id)
//         res.send("Note deleted")
//     } catch (err) {
//         return res.status(500).send("Internal Error")
//     }
// })


// //Delet All Notes ROUTE 5 :Login
// router.delete('/deleteallnotes', decodeToken, async (req, res) => {


//     try {
//         let notes = await Note.find({ userId: req.userId })
//         if (!notes) {
//             return res.send("No note")
//         }
//         notes.forEach(async note => {
//             await Note.findByIdAndDelete(note.id)
//         });

//         res.send("Notes deleted")
//     } catch (err) {
//         return res.status(500).send("Internal Error")
//     }
// })


module.exports = router