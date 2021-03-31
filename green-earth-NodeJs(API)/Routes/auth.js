const express = require('express')
const router = express.Router()
const User = require('../Models/User')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const requireLogin = require('../middleware/auth')

router.get('/', (req,res) => {
    res.send("hello")
})



router.post('/signup', (req, res) => {
    const { email, password,name} = req.body
    if (!email || !password || !name) {
        return res.status(422).json({ error: "please add all the fields" })
    }
    User.findOne({ email:email })
        .then((savedUser) => {
          if(savedUser){
              return res.status(422).json({
                error:"email already taken"
            })
          }
                bcrypt.hash(password, 12)
                    .then(hashedpassword => {
                        const user = new User({
                            email,
                            password: hashedpassword,
                            name:name
                        })
                        user.save()
                            .then(user => {
                                res.json({ message: "saved successfully" })
                            })
                            .catch(err => {
                                console.log(err)
                            })

                    })      
        })
        .catch(err => {
            console.log(err)
        })
})



router.post('/signin', (req, res) => {
    const { email, password} = req.body
    if (!email || !password ) {
        return res.status(422).json({ error: "please input all fields" })
    }
    User.findOne({ email: email })
        .then(savedUser => {
            if (!savedUser) {
                return res.status(422).json({ error: "Invalid Email or Password" })
            }
            bcrypt.compare(password, savedUser.password)
                .then(doMatch => {
                    if (doMatch) {
                        console.log(savedUser)
                        const token = jwt.sign({ _id: savedUser._id }, "secret")
                        const { _id, name, email,avatarId,score} = savedUser
                        res.json({ token, user: { _id, name, email,avatarId,score  } })
                    }
                    else {
                        return res.status(422).json({ error: "Invalid email or password" })
                    }
                })
                .catch(err => [
                    console.log(err)
                ])
        })
})

router.get('/user', requireLogin, (req,res) => {

    User.findById(req.user._id)
    .select('-password')
    .then( user => res.json(user))
})



module.exports = router