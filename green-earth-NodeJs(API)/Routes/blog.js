const express = require('express')
const router = express.Router()
const Blog = require('../Models/Blog')


router.get('/allblogs', (req,res) => {
    Blog.find()
    .then(result => {
        res.json(result)
    })
    .catch(err => {
        console.log(err)
    })
})

router.get('/getblog/:blogId',(req,res) => {
  Blog.findById(req.params.blogId)
  .then((blog) => {
      res.json(blog)
    //   console.log(blog);
  })
  .catch(err => {
       console.log(err);
  })
})


router.post('/postblog', (req,res) => {
    const { title, blogImage,blogBody} = req.body
    if(!title || !blogImage || !blogBody){
        return res.status(422).json({error: "please add all the fields"})
    }
    
    const blogData = new Blog({
        title,
        blogImage,
        blogBody,
        blogDate: new Date()
    })

    blogData.save()
      .then(blog => {
          res.json({message: "blog posted successfully"})
      })
      .catch(err => {
          res.json(err)
      })

})


router.patch('/updateblog/:blogid',async(req, res) => {
    const updates = Object.keys(req.body)
    const allowedUpdates = ['title', 'blogImage', 'blogBody']
    const isValidOperations = updates.every((update) => {
       return allowedUpdates.includes(update)
    })

    if (!isValidOperations) {
        return res.status(400).send({ error: "Invalid updates" })
    }

    const blogId = req.params.blogid;
   

    try{
        const blogdoc  = await Blog.findOne({_id: blogId})


        if(!blogdoc){
            return res.status(404).send();
        }

        updates.forEach( (update) => {
            blogdoc[update] = req.body[update]
        })

        await blogdoc.save()
      
        res.send(blogdoc)
    }catch(err){
        res.status(400).send(e)
    }

  
})








module.exports = router