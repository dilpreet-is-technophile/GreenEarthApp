import 'package:flutter/material.dart';

class BlogView extends StatefulWidget {

  final String blogImage, title, blogBody,index;
  final String blogDate;
  BlogView({this.blogBody,this.blogDate,this.blogImage,this.title,this.index});

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Blogs",
            style: TextStyle(color: Colors.teal[900], fontWeight: FontWeight.w600),
          ),
        iconTheme: IconThemeData(
          color: Colors.teal[900]
        ),
        // actions: <Widget>[
        // Opacity(
        // opacity:0,
        // Container(
        //     padding: EdgeInsets.symmetric(horizontal: 16),
        //     child: Icon(Icons.share,))
        // ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom:20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Hero(
                              tag:"Different"+widget.index,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    widget.blogImage,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(height: 12,),
                            Text(
                              widget.title==null?"":widget.title,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              widget.blogBody==null?"":widget.blogBody,
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.blogDate==null?"":widget.blogDate,
                              style: TextStyle(color: Colors.grey, fontSize: 7),
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}