import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';

// var InternetStatus = "Unknown";
// var contentmessage = "Unknown";
//
// Widget _showDialog(String err,String content ,BuildContext context) {
//   showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             title: new Text(err),
//             content: new Text(content),
//             actions: <Widget>[
//               new FlatButton(
//                   onPressed: () async {
//                     Navigator.of(context).pop();
//                     if(await internetChecker(context)==true){
//                       setState(() {
//
//                       });
//                     }
//                     else{
//                       _showDialog('err', 'retry', context);
//                     }
//                   },
//                   child: new Text("Try Again"))
//             ]
//         );
//       }
//   );
// }

// Future<List<Map<String, dynamic>>> getMultipleData(String token) async {
//   if(await DataConnectionChecker().hasConnection){
//     try {
//       var value = <Map<String, dynamic>>[];
//       var res1 =http.get(
//           "https://green-earth.herokuapp.com/user",
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'authorization': 'Bearer ' + '$token'
//           }
//       );
//       var results = await Future.wait([res1]); // list of Responses
//       for (var response in results) {
//         print(response.statusCode);
//         if(response.statusCode==200) {
//           value.add(json.decode(response.body));
//         }
//       }
//       print('[[[[[[[[[[[[**************$value************]]]]]');
//       return value;
//     } on SocketException catch (e) {
//       print(e);
//     }
//    }
//    else{
//
//    }
// }
//
// Future<bool> internetChecker(BuildContext context) async{
//   // if(check=true){
//   //   return true;
//   // }
//   // else{
//   //   return false;
//   // }
//   if( await DataConnectionChecker().hasConnection){
//     return true;
//     // Future<bool>.value(true);
//   }
//   else{
//     InternetStatus = "You are disconnected to the Internet. ";
//     contentmessage = "Please check your internet connection";
//     _showDialog(InternetStatus,contentmessage,context);
//     return false;
//     // Future<bool>.value(false);
//   }
// }