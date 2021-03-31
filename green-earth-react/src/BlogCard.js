import React from "react";
import "./BlogCard.css";
import { useHistory} from 'react-router-dom'

function BlogCard({title,blogBody,blogId,blogImage}) {
    const history = useHistory();
  return (
    <div>
      <div className="individualblogcard">
        <img
          src={blogImage}
          alt="lrs"
        />
        <div className="individualblogcard-text">
          <h2>{title}</h2>
          {/* <p>8 November 2020</p> */}
          <button
   onClick={ () => history.push(`/blog/${blogId}`)} 
          >
            View More
          </button>
        </div>
      </div>
    </div>
  );
}

export default BlogCard;
