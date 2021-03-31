import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_earth/Blogs/BlogTile.dart';
import 'package:http/http.dart' as http;
import 'BlogData.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blogs",
          style:
              TextStyle(color: Colors.teal[900], fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.teal[900]),
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
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: FutureBuilder(
            future: fetchBlogList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('In blogs: +${snapshot.data}++++++------------------');
              // if(snapshot.connectionState==ConnectionState.done){
              // if(checking(context) == true){
              if (snapshot.hasError) {
                print("++++++++ ${snapshot.error}");
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Hero(
                        tag: "Different" + index.toString(),
                        child: BlogTile(
                          index: index.toString(),
                          blogImage: snapshot.data[index].blogImage ?? "",
                          title: snapshot.data[index].title ?? "",
                          blogDate: snapshot.data[index].blogDate ?? "",
                          blogBody: snapshot.data[index].blogBody ?? "",
                        ),
                      );
                    });
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }

  Future fetchBlogList() async {
    try {
      final http.Response res = await http.get(
          "http://green-earth.herokuapp.com/allblogs",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      List<Blog> blogList = [];
      // if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      print("!!!!!!!!!1  $jsonData ................");
      for (var b in jsonData) {
        print("@@@@@@@");
        Blog blog = Blog(
            title: b['title'],
            blogImage: b['blogImage'],
            blogBody: b['blogBody'],
            blogDate: b['blogDate']);
        blogList.add(blog);
      }
      print("............$jsonData ................");
      // }
      return blogList;
    } catch (e) {
      print('');
      print('');
      return Text('Data not fetched due to $e');
      print('');
      print('');
    }
  }
}
