import React, { useState } from "react";
import { useHistory} from "react-router-dom"
import './Blog.css'
function Blog() {

  const history = useHistory();
  const [title, setTitle]= useState("")
  const [imageURL, setImageURL]= useState("")
  const [body, setBody]= useState("")

  const onSubmit = () => {
    fetch('/postblog',{
      method:"post",
      headers:{
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        title:title,
        blogImage:imageURL,
        blogBody:body
      })
    })
    .then(res => res.json)
    .then(result => {
      if(result){
        console.log("posted succeessfully")
        history.push("/allblogs")
      }
    })
    .catch(err => {
      console.log(err)
    })
  }

  return (
    <div className="blogcomponent">
      <h2>Blog posts</h2>

      <form onSubmit={(e) => {e.preventDefault() 
        onSubmit()}}>
        <div className="blogform">
          <label>Title</label>
          <input value={title} onChange={(e) => setTitle(e.target.value)} type="text" />
          <label>Image Url</label>
          <input value={imageURL} onChange={(e) => setImageURL(e.target.value)} type="text" />
          <label>Body</label>
          <textarea value={body}  onChange={(e) => setBody(e.target.value)} cols="40" rows="10"></textarea>
          <button type="submit">Submit</button>
        </div>
      </form>
    </div>
  );
}

export default Blog;
