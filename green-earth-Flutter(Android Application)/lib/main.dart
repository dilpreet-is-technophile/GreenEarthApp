import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_earth/LoginNotifier.dart';
import 'package:green_earth/NavigatingPages/leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:green_earth/Home%20Page/mainpage.dart';
import 'package:green_earth/login_page/login.dart';
import 'package:green_earth/parent_inherit.dart';
import 'package:green_earth/json_convertors/tokenClass.dart';
import 'dart:convert';
import 'NavigatingPages/hiddenDrawer.dart';

bool checkingKey;
String tokenName;
TokenClass token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  const defaultJson = '{}';
  var prefs = await SharedPreferences.getInstance();
  checkingKey = prefs.containsKey("jwt");
  // if(checkingKey==true){
  tokenName=prefs.getString('jwt');
  print('');
  print('^^^^^^^^?####$tokenName####?^^^^^^^');
  print('');
  Map<String, dynamic> valueMap = jsonDecode(tokenName??defaultJson);
  print("printing value map $valueMap");
  token=TokenClass.fromJson(valueMap);
  print("lol      ${token.token}");
  // }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<LoginNotification>(
      onNotification: (loginNotification){
        setState((){
          token = loginNotification.token;
          checkingKey = true;
        });
        return true;
      },
      child: parent_inherit(
        token: checkingKey?token.token:'',
        name: checkingKey?token.name:'',
        email: checkingKey?token.email:'',
        score: checkingKey?token.score:'',
        avatarID: checkingKey?token.avatarID:'',
        child: MaterialApp(
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                color: Color(0xffccffcc),
                child: !checkingKey ? LoginPage() : MainPageDrawer(token.token),
              ),
            ),
          ),
          routes: <String,WidgetBuilder>{
            '/home':(BuildContext context) => MainPageDrawer(token.token),
            '/login':(BuildContext context) => LoginPage(),
            '/leaderBoard':(BuildContext context) => LeaderBoard(),
          },
        ),
      ),
    );
  }
}