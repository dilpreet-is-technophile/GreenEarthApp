import 'dart:async';

import 'package:flutter/material.dart';

class ArticleView extends StatefulWidget {

  final String imgUrl, title, desc, content,publishedAt,index;
  ArticleView({this.imgUrl, this.desc, this.title, this.content,this.publishedAt,this.index});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
                "News",
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
                                  widget.imgUrl,
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
                            height: 10,
                          ),
                          Text(
                            widget.desc==null?"":widget.desc,
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.publishedAt==null?"":widget.publishedAt,
                            style: TextStyle(color: Colors.grey[900], fontSize: 7),
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