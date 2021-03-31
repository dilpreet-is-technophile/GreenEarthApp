// import 'dart:async';
//
// import 'package:green_earth/Home Page/mainpage.dart';
// import 'package:flutter/material.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
//
// class checkInternet{
//   Function callback;
//   StreamSubscription<DataConnectionStatus> listener;
//   var InternetStatus = "Unknown";
//   var contentmessage = "Unknown";
//
//   checkInternet({this.callback});
//
//   void _showDialog(String err,String content ,BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               title: new Text(err),
//               content: new Text(content),
//               actions: <Widget>[
//                 new FlatButton(
//                     onPressed: () {
//                       widget.update();
//                     },
//                     child: new Text("Try Again"))
//               ]
//           );
//         }
//     );
//   }
//
//     Future checkConnection(BuildContext context) async{
//       listener = DataConnectionChecker().onStatusChange.listen((status) {
//         switch (status){
//           case DataConnectionStatus.connected:
//             return "DataConnectionState.connected";
//             break;
//           case DataConnectionStatus.disconnected:
//             InternetStatus = "You are disconnected to the Internet. ";
//             contentmessage = "Please check your internet connection";
//             _showDialog(InternetStatus,contentmessage,context);
//             break;
//         }
//       });
//       return await DataConnectionChecker().connectionStatus;
//     }
//
// }