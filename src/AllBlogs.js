import React, { useEffect, useState } from "react";
import "./AllBlogs.css";
import BlogCard from "./BlogCard";
function AllBlogs() {
  const [blogs, setBlogs] = useState(null);
  useEffect(() => {
    fetch("/allblogs", {
      method: "get",
    })
      .then((res) => res.json())
      .then((result) => {
        console.log(result);
        setBlogs(result);
      })
      .catch((err) => console.log(err));
  }, []);
  return (
    <div>
      <h2>all blogs are here</h2>
      <div className="blogcards">
        {blogs
          ? blogs.map((item) => {
              return(
                <div key={item._id}>
                <BlogCard
                  blogId={item._id}
                  title={item.title}
                  blogbody={item.blogBody}
                  blogImage={item.blogImage}
                />
              </div>
              )
           
            })
          : "loading"}
      </div>
    </div>
  );
}

export default AllBlogs;
