const mongoose = require('mongoose')




const blogSchema = new mongoose.Schema({
    title: {
        type: String,
        required:true
    },
    blogImage:{
         type:String
    },
    blogBody:{
        type:String,
        required:true
    },
    blogDate: {
        type:Date
    }
 
})


const Blog =mongoose.model("Blog", blogSchema)

module.exports = Blog