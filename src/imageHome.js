import React, { useEffect, useState } from "react";
import "./imageHome.css";

function ImageHome() {
  const [images, setImages] = useState(null);

  useEffect(() => {
    fetch("/imagedata", {
      method: "get",
    })
      .then((res) => res.json())
      .then((result) => {
        console.log(result);
        setImages(result);
      })
      .catch((err) => console.log(err));
  } ,[]);

  

  const onRight = (id) => {
    fetch('/setstatustrue',{
      method:"post",
      headers:{
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        fileId:id
      })
    })
    .then(res => res.json())
    .then(result => {
      if(result){
        console.log("update  succeessfully")
        console.log(result)
      //   const newData = images.map(item=>{
      //     if(item.id==result.fileId){
      //         return result
      //     }else{
      //         return item
      //     }
      // })
      const newData = images.filter(item=>{
        return item.id !== result.fileId
    })
      setImages(newData)
      }
    })
    .catch(err => {
      console.log(err)
    })
  }

  const onWrong = (id) => {
    fetch('/setstatusfalse',{
      method:"post",
      headers:{
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        fileId:id
      })
    })
    .then(res => res.json())
    .then(result => {
      if(result){
        console.log("update succeessfully")
        const newData = images.filter(item=>{
          return item.id !== result.fileId
      })
        setImages(newData)
      }
    })
    .catch(err => {
      console.log(err)
    })
  }


  return (
    <div className="image-view">
      {images
        ? images.map((item) => {
          const imageQuality = item.thumbnailLink;
          const thumbnail = imageQuality.replace(/=s220/i, "=s720");
            return (
              <div key={item.id} className="image-view-items">
                {/* <img src={item.thumbnailLink} alt="hello" /> */}
                <img src={thumbnail} alt="hello" />
                <div className="control-buttons">
                <button onClick={(e) => onRight(item.id)}>Right</button>
                <button onClick={(e) => onWrong(item.id)}>Wrong</button>
                </div>
              </div>
            );
          })
        : "loading"}
    </div>
  );
}

export default ImageHome;
