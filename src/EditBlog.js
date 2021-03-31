import React,{useEffect,useState} from "react";
import { useParams ,useHistory} from "react-router-dom"
import "./EditBlog.css";


function EditBlog() {
    const {blogId } = useParams()
    const history = useHistory();
    const [title, setTitle]= useState("")
    const [imageURL, setImageURL]= useState("")
    const [body, setBody]= useState("")


    useEffect(() => {
        fetch(`/getblog/${blogId}`, {
            headers:{
                "Content-Type": "application/json"
              },
        })
            .then(res => res.json())
            .then(result => {
                console.log("this is post result", result) 
                setTitle(result.title)
                setImageURL(result.blogImage)
                setBody(result.blogBody)
            })
    }, [])


    const onSubmit = () => {
        fetch(`/updateblog/${blogId}`,{
          method:"PATCH",
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
              console.log(result)
            console.log("posted succeessfully")
            history.push("/allblogs")
          }
        })
        .catch(err => {
          console.log(err)
        })
      }


  return (
    <div>
      <div className="blogcomponent">
        <h2>Blog posts</h2>

        <form
          onSubmit={(e) => {
            e.preventDefault();
            onSubmit();
          }}
        >
          <div className="blogform">
            <label>Title</label>
            <input
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              type="text"
            />
            <label>Image Url</label>
            <input
              value={imageURL}
              onChange={(e) => setImageURL(e.target.value)}
              type="text"
            />
            <label>Body</label>
            <textarea
              value={body}
              onChange={(e) => setBody(e.target.value)}
              cols="40"
              rows="10"
            ></textarea>
            <button type="submit">Submit</button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default EditBlog;
