import 'package:flutter/material.dart';
import 'package:green_earth/Home Page/mainpage.dart';
import 'package:flutter/rendering.dart';
import 'package:green_earth/NavigatingPages/Profile%20Page.dart';
import 'package:green_earth/NavigatingPages/leaderboard.dart';
import 'package:green_earth/login_page/login.dart';
import 'package:green_earth/service/login_signup_Auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:green_earth/parent_inherit.dart';

import '../Blogs/Blogs.dart';


const Color cool = Color(0xFF181A2F);
// const Color avtar_backGround = Color(0xFF2FCB72);
const Color avtar_backGround1 = Color(0xFF0C3329);
const Color prof_Card = Color(0xFF196F3D);
const Color grade1 = Color(0xFF00b09b);
const Color grade2 = Color(0xFF96c93d);
const clickedColor = Color(0xFF0C3329);
const unclickedColor = Color(0xFF196F3D);
Color probtn = Color(0xFF0C3329);
Color leadbtn = Color(0xFF196F3D);
Color x = Color(0xff40878b);

class MainPageDrawer extends StatelessWidget {
  final String token;
  MainPageDrawer(this.token);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(token),
            MainPage(token),
          ],
        ),
      ),
    );
  }
}
String name;
class DrawerScreen extends StatelessWidget {
  final String token;
  DrawerScreen(this.token);
  @override
  Widget build(BuildContext context) {
    name =parent_inherit.of(context).name;
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 40, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/profileIcon/PicsArt_03-26-07.51.41.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  DrawerItem(
                    text: 'Home',
                    icon: Icons.home,
                    goto: MainPage(token),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DrawerItem(
                    text: 'Profile',
                    icon: Icons.person,
                    goto: ProfileSetter(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DrawerItem(
                    text: 'LeaderBoard',
                    icon: Icons.leaderboard_rounded,
                    goto: LeaderBoard(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DrawerItem(
                    text: 'Blogs',
                    icon: Icons.comment_rounded,
                    goto: BlogPage(),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // DrawerItem(
                  //   text: 'Share',
                  //   icon: Icons.share,
                  // ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
              GestureDetector(
                onTap: (){
                  print("lohhhh");
                  logoutOutOfApp(context);
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.logout,
                        color: Colors.black.withOpacity(1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log out',
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Logging Out..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final  goto;
  const DrawerItem({
    Key key,
    this.icon,
    this.text,this.goto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secAnimation,
                    Widget child) {
                  animation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.bounceIn);
                  return ScaleTransition(
                    scale: animation,
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secAnimation) {
                  return goto;
                }));
      },
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black,fontSize: 15),
          )
        ],
      ),
    );
  }
}