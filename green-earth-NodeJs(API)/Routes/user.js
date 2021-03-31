const express = require('express')
const router = express.Router()
const User = require('../Models/User')
const requireLogin = require('../middleware/auth')


router.patch('/userupdate',requireLogin, async (req, res) => {
    const updates = Object.keys(req.body)
    const allowedUpdates = ['name', 'score', 'mobileNumber','avatarId']
    const isValidOperations = updates.every((update) => {
       return allowedUpdates.includes(update)
    })

    if (!isValidOperations) {
        return res.status(400).send({ error: "Invalid updates" })
    }

    try {
        updates.forEach((update) => {
            req.user[update] = req.body[update]
        })
        await req.user.save()
        res.send(req.user)
    } catch (e) {
        res.status(400).send(e)
    }
})

router.get('/allusers', requireLogin, (req, res) => {
    User.find()
        .sort({score: -1})
        .select(" -password")
        .then(result => {
            res.json(result)
        })
        .catch(err => {
            console.log(err)
        })
})


router.post('/getgoogleid',(req,res)=>{
    User.find( {"postDates.postgoogleid": req.body.googleid})
        .then(doc => {
            
            res.send(doc)

        })
        .catch(err => {
             console.log(err)
        })
})


router.get('/upgo',(req,res) => {
    User.updateOne({"postDates.postgoogleid":"1RG8lnVOf-6xsiUpdQ3ctXPAYicRe5Vay"},
    {$set: {"postDates.$.status": false}}
    )
    .then(doc => {
        res.send(doc);
    })
    .catch(err => {
        console.log(err)
    })
})


module.exports = router