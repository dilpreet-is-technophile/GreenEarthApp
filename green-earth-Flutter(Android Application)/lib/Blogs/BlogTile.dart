import 'package:flutter/material.dart';
import 'package:green_earth/Blogs/BlogView.dart';

class BlogTile extends StatelessWidget {
  final String index;
  final String title;
  final String blogBody;
  final String blogImage;
  final String blogDate;

  BlogTile({this.index,this.title,this.blogImage,this.blogBody,this.blogDate});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation) => BlogView(
            index: index,
            blogBody: blogBody,
            blogDate: blogDate,
            blogImage: blogImage,
            title: title,
          ),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
        );
      },
        child: Container(
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
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          blogImage,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(height: 12,),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      blogBody,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    )
                  ],
                ),
              ),
            )),
      );
  }
}
