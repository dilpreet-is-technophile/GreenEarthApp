import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:green_earth/parent_inherit.dart';


import '../main.dart';

const Color backGround = Color(0xFF092C28);

var selectedAvatar = "assets/images/profileIcon/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png";
String token;
String name;
String email;
String score;
String avatarID;
final List myAvatar = [
    "assets/images/profileIcon/PicsArt_03-25-01.31.34 (1).png",
  "assets/images/profileIcon/PicsArt_03-26-07.49.03.png",
  "assets/images/profileIcon/PicsArt_03-25-01.56.50.png",
  // "assets/images/profileIcon/PicsArt_03-26-07.49.46.png",
  "assets/images/profileIcon/PicsArt_03-26-07.50.43.png",
  "assets/images/profileIcon/PicsArt_03-26-07.51.11.png",
  "assets/images/profileIcon/PicsArt_03-26-07.51.41.png",
  "assets/images/profileIcon/PicsArt_03-26-07.52.09.png",
 "assets/images/profileIcon/PicsArt_03-26-07.52.49.png",
];

final List avatarList = ["1", "2", "3", "4", "5" ,"6" ,"7","8"];

class ProfileSetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner:false,color: Colors.grey[200], home: ProfilePage());
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    token = parent_inherit.of(context).token;
    name = parent_inherit.of(context).name;
    email= parent_inherit.of(context).email;
    score=parent_inherit.of(context).score;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ProfileCurve(),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyListItem(
                    icons: Icons.alternate_email,
                    title: "username",
                    subtitle: name,
                  ),
                  MyListItem(
                    icons: Icons.email_outlined,
                    title: "e-mail",
                    subtitle: email,
                  ),
                  MyListItem(
                    icons: Icons.leaderboard_rounded,
                    title: "Score",
                    subtitle: score,
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: FloatingActionButton(
                          backgroundColor: backGround,
                          onPressed: () {
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
                                          curve: Curves.easeInToLinear);
                                      return ScaleTransition(
                                        scale: animation,
                                        alignment: Alignment.center,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secAnimation) {
                                      return EditScreen(token);
                                    }));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCurve extends StatefulWidget {

  @override
  _ProfileCurveState createState() => _ProfileCurveState();
}

class _ProfileCurveState extends State<ProfileCurve> {
  // var selectedAvatar="assets/images/profileIcon/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png";

  @override
  Widget build(BuildContext context) {
    token = parent_inherit.of(context).token;
    name = parent_inherit.of(context).name;
    return CustomPaint(
      child: Stack(
        children: [
          Container(
          height: 200.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 45, left: 30),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey[200],
                          letterSpacing: 1.0),
                    ),
                    Text(
                      email,
                      style: TextStyle(color: Colors.grey[200], fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
          Positioned(
            top: 65.0,
            right: 40.0,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/profileIcon/PicsArt_03-26-07.51.41.png"),
              radius: 50,
            ),
          )
      ]
      ),
      // size: Size(1000,(1000*0.5).toDouble()),
      painter: MyCurve(),
    );
  }
}

class MyCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset(size.width * 0.30, size.height * 0.45),
          Offset(size.width * 0.50, size.height * 0.45),
          [backGround, backGround.withOpacity(0.9)])
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.7000000);
    path_0.quadraticBezierTo(size.width * 0.1762000, size.height * 0.9332000,
        size.width * 0.2904000, size.height * 0.9112000);
    path_0.quadraticBezierTo(size.width * 0.4827500, size.height * 0.8913000,
        size.width, size.height * 0.4572000);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.0002000, 0);
    path_0.lineTo(0, size.height * 0.7000000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class EditScreen extends StatefulWidget {
  final String token;
  EditScreen(this.token);
  @override
  _EditScreenState createState() => _EditScreenState();
}

Future<void> updateProfilePage(String username,String avatarId,String token) async {
  print("");

  print("Entered in updateProfilePage() function");
  print("");
  avatarId = avatarId;

   name= username;


  print("");

  print("username    $username");
  print("");

  print("avatarId     $avatarId");
  print("");

  try {
    final http.Response res =
    await http.patch("http://green-earth.herokuapp.com/userupdate", body: {
      "avatarId": avatarId,
      "name": username,
    }, headers: {
      'authorization':
      'Bearer '+token
    });

    print(res.body);

    if (res.statusCode == 200) {
      name=username;
      print("data updated on server");
      print("");

      print(res.body);
    } else {
      print(res.statusCode);
    }


  }
  catch (e) {
    print(e);
  }





}

class _EditScreenState extends State<EditScreen> {
  TextEditingController usernameController=TextEditingController(text: name);
  String username;
  String avatarId;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    token = parent_inherit.of(context).token;
    name = parent_inherit.of(context).name;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            //   Navigator.of(context).pop();
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => EditScreen(token)),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              child: Align(
                alignment: Alignment.bottomRight,
              ),
              backgroundImage:AssetImage(selectedAvatar),
              radius: 50,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Our Hero deserves a cool avatar and a username !!!",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: usernameController,
                  decoration: InputDecoration(
                      labelText: "UserName",
                      fillColor: Colors.grey[100],
                      filled: true,
                      prefixIcon: Icon(Icons.person_rounded, color: backGround),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF29a329))),
                      labelStyle: TextStyle(color: Color(0xFFbfbfbf))),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                width: 400,
                height: 300,
                //color: Colors.grey[100],
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                  ),
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatar = myAvatar[index];
                            avatarId = index.toString();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(3.0),
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: CircleAvatar(
                            // radius: 10,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(myAvatar[index]),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: myAvatar.length,
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        //   child: ,
        //
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: backGround)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Profile not Updated",
                      toastLength: Toast.LENGTH_SHORT);
                },
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                textColor: backGround,
                child: Text("Cancel", style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: backGround)),
                onPressed: () {
                  print("zzzzzzzzzzzzzzzzzzzzzzzzzzz");
                  print(usernameController.text);
                  username = usernameController.text;
                  print("username   $name");
                  print('avatarId    $avatarId');

                  updateProfilePage(username, avatarId,token);
                  print("function called updateProfilePage() ");

                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Profile Updated",
                      toastLength: Toast.LENGTH_SHORT);
                },
                padding: EdgeInsets.all(10.0),
                color: backGround,
                textColor: Colors.white,
                child: Text("Save", style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MyListItem extends StatelessWidget {
  final IconData icons;
  final String title;
  final String subtitle;

  MyListItem({this.icons, this.title, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 70,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                color: backGround,
                width: 70,
                height: 70,
                child: Icon(icons, color: Colors.white),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title),
                    Text(subtitle, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}