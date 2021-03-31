const mongoose = require('mongoose')




const userSchema = new mongoose.Schema({
    name: {
        type: String,
        default: "user1"
    },
    avatarId:{
        type:Number,
        default:0
    },
    password: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    score:{
        type:Number,
        default:0
    },
    mobileNumber:{
        type: Number,
        minlength:10,
        trim:true
    },
    // postDates:[{
    //     type:Date,
    //    status:{
    //        type:Boolean,
    //        default:true
    //    }
    // }]
    postDates:[{
       datedata:{
           type:Date
       },
       status:{
           type:Boolean,
           default:false
       },
       postgoogleid:{
           type:String
       }
    }]
 
})


const User =mongoose.model("User", userSchema)

module.exports = User