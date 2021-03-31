const express = require('express')
const app = express()
const mongoose = require('mongoose')
const PORT = process.env.PORT || 5000
const userauth = require('./Routes/auth')
const userRoute = require('./Routes/user')
const blogRoute = require('./Routes/blog')
const userUpload = require('./app')



mongoose.connect('mongodb+srv://harvin:harvinmongo@cluster1.vcjgv.mongodb.net/googleproject?retryWrites=true&w=majority',{ useNewUrlParser: true,useUnifiedTopology: true ,useFindAndModify: false})
mongoose.connection.on('connected', () => {
    console.log("connected to database")
})
mongoose.connection.on('error', (err) => {
    console.log("error in connecting",err)
})



app.use(express.json())


app.use(userauth)
app.use(blogRoute)
app.use(userRoute)
app.use(userUpload)



app.listen(PORT, () => {
    console.log('server started at port 5000...')
})