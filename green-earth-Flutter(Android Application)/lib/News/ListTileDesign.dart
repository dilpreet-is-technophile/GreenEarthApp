import 'package:flutter/material.dart';

import 'ArticleView.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content,publishedAt,index;

  NewsTile(
      {this.imgUrl, this.desc, this.title, this.content,this.publishedAt,this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) => ArticleView(
              imgUrl: imgUrl,
              title: title,
              desc: desc,
              content: content,
              publishedAt: publishedAt,
              index: index,
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
      child: GestureDetector(
        // onTap: (){
        //   Navigator.push(context, MaterialPageRoute(
        //       builder: (context) => ArticleView(
        //         postUrl: posturl,
        //       )
        //   ));
        // },
        child: Container(
            // margin: EdgeInsets.only(top: 15, bottom: 1),
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6))),
                // child: Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    color: Colors.grey.withOpacity(0.5),
                    child: Container(
                      child: ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              imgUrl,
                              height: 175,
                              width: 115,
                              fit: BoxFit.cover,
                            )),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xffB6EFAC),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(desc,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                // ),
              ),
            )),
      ),
      // child: Container(
      //     margin: EdgeInsets.only(top:15,bottom:1),
      //     width: MediaQuery
      //         .of(context)
      //         .size
      //         .width,
      //     child: Container(
      //       child: Container(
      //         padding: EdgeInsets.symmetric(horizontal: 10),
      //         // alignment: Alignment.bottomCenter,
      //         // decoration: BoxDecoration(
      //         //     borderRadius: BorderRadius.only(
      //         //         bottomRight: Radius.circular(6),
      //         //         bottomLeft: Radius.circular(6))
      //         // ),
      //         child: Row(
      //           // crossAxisAlignment: CrossAxisAlignment.start,
      //           // mainAxisSize: MainAxisSize.min,
      //           children: <Widget>[
      //             ClipRRect(
      //                   borderRadius: BorderRadius.circular(6),
      //                   child: Image.network(
      //                     imgUrl,
      //                     height: 75,
      //                     width: 115,
      //                     fit: BoxFit.cover,
      //                   )),
      //             SizedBox(width: 12,),
      //             Column(
      //               children: [
      //                 // // Flexible(
      //                 // //   child: Text(
      //                 // //     title,
      //                 // //     maxLines: 2,
      //                 // //     textDirection: TextDirection.rtl,
      //                 //     textAlign: TextAlign.justify,
      //                 // //     overflow: TextOverflow.ellipsis,
      //                 // //     softWrap: true,
      //                 // //     style: TextStyle(
      //                 // //         color: Color(0xffB6EFAC),
      //                 // //         fontSize: 16,
      //                 // //         fontWeight: FontWeight.bold),
      //                 // //   ),
      //                 // // ),
      //                 // SizedBox(
      //                 //   height: 4,
      //                 // ),
      //                 // Expanded(
      //                 //   child: Text(
      //                 //     desc,
      //                 //     textDirection: TextDirection.rtl,
      //                 //     textAlign: TextAlign.justify,
      //                 //     overflow: TextOverflow.ellipsis,
      //                 //     softWrap: true,
      //                 //     maxLines: 2,
      //                 //     style: TextStyle(color: Colors.white, fontSize: 12),
      //                 //   ),
      //                 // )
      //                 Text(title,
      //                     maxLines: 2,
      //                     softWrap: false,
      //                     style: TextStyle(
      //                         color: Color(0xffB6EFAC),
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold),
      //                     overflow: TextOverflow.ellipsis),
      //                 SizedBox(
      //                   height: 4,
      //                 ),
      //                 Text(desc,
      //                     softWrap: false,
      //                     maxLines: 2,
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 12,
      //                     ),
      //                     overflow: TextOverflow.ellipsis),
      //                 // Text(
      //                 //   content,
      //                 //   overflow: TextOverflow.ellipsis,
      //                 // )
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     )),
    );
  }
}