import 'dart:convert';
import 'package:green_earth/login_page/login.dart';

import '../LoginNotifier.dart';
// import 'file:///C:/Users/SHIVAM%20GOYAL/AndroidStudioProjects/green-earth-frontend/lib/json_convertors/tokenClass.dart';
import 'package:green_earth/json_convertors/tokenClass.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:green_earth/parent_inherit.dart';

Future attemptLogIn(String username, String password,BuildContext context) async {
  // String parentToken= parent_inherit.of(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("$username $password");
  final http.Response res = await http.post(
      "https://green-earth.herokuapp.com/signin",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": username,
        "password": password
      }),
  );
  print("%%%%%${res.statusCode}");
  if(res.statusCode == 200) {
    prefs.setString('jwt',res.body);
    var value=prefs.getString('jwt');
    Map<String,dynamic> valueMap=jsonDecode(value);
    print("checker $valueMap");
    TokenClass token=TokenClass.fromJson(valueMap);
    print('');
    print("@@@@@@@@@@@@@@@@@@");
    print(token.token);
    print('@@@@@@@@@@@@@@@@@@');
    print('');
    // tokenCorrector(token.token);
    LoginNotification(token).dispatch(context);

    return res.statusCode;
  }
  else{
    return res.statusCode;
      _showMyDialoglogin(context,res.statusCode);
  }
}

Future<void> attemptSignUp(String username, String password,String nameOfUser,BuildContext context) async {
  final http.Response res = await http.post(
          'https://green-earth.herokuapp.com/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, String>{
        "email":username,
        "password":password,
          "name":nameOfUser
      }),
  );
  if (res.statusCode==200){
    Fluttertoast.showToast(msg: 'Signed up');
    ///? To ask about navigation on signing up
    // Navigator.of(context).pushNamed('/home');
  }
  else{
    _showMyDialogSignup(context,res.statusCode);
  }
}
// print("res status code=${res.statusCode}  $username $password ${jsonDecode(res.body)}")

void logoutOutOfApp(BuildContext context) async{
  // final storage =parent_inherit.of(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  // Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
      LoginPage()), (route) => false);

  // Navigator.pushAndRemoveUntil(
  //     context,
  //     PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
  //         Animation secondaryAnimation) {
  //       return LoginPage();
  //     }, transitionsBuilder: (BuildContext context, Animation<double> animation,
  //         Animation<double> secondaryAnimation, Widget child) {
  //       return new SlideTransition(
  //         position: new Tween<Offset>(
  //           begin: const Offset(1.0, 0.0),
  //           end: Offset.zero,
  //         ).animate(animation),
  //         child: child,
  //       );
  //     }),
  //         (Route route) => false);
}

Future<void> _showMyDialogSignup(BuildContext context,int statuscode) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              statuscode==422?Text('Email ID is already taken. Please try again!'):Text('Signing Up failed with status code $statuscode'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showMyDialoglogin(BuildContext context,int statuscode) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              statuscode==422?Text('Invalid email or password. Please try again!'):Text('Authorisation was failed with status code $statuscode'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
