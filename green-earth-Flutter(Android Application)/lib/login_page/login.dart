import 'package:green_earth/NavigatingPages/hiddenDrawer.dart';
import 'package:green_earth/login_page/iconandtext.dart';
import 'package:flutter/material.dart';
import 'package:green_earth/service/login_signup_Auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginUsernameController=TextEditingController();
  final TextEditingController loginPasswordController=TextEditingController();
  final TextEditingController signupUsernameController=TextEditingController();
  final TextEditingController signupNameOfUserController=TextEditingController();
  final TextEditingController signupPasswordController=TextEditingController();
  String loginUsername;
  String loginPassword;
  String signupUsername;
  String signupPassword;
  String nameOfUser;
  GlobalKey<FormState> formkey1= GlobalKey<FormState>();
  GlobalKey<FormState> formkey2= GlobalKey<FormState>();
  bool _isloading=false;

  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFF008000);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  // bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();

    loginPasswordController.addListener(() {setState(() {});});
    loginUsernameController.addListener(() {setState(() {});});
    signupPasswordController.addListener(() {setState(() {});});
    signupUsernameController.addListener(() {setState(() {});});
    signupNameOfUserController.addListener(() {setState(() {});});

    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     setState(() {
    //       _keyboardVisible = visible;
    //       print("Keyboard State Changed : $visible");
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {

    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;

    switch(_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = Color(0xFF008000);
        _headingColor = Colors.white;

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = MediaQuery.of(context).viewInsets.bottom!=0 ? 130 : 260;
        _loginHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 240;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Color(0xFF008000);
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginYOffset = MediaQuery.of(context).viewInsets.bottom!=0 ? 115 : 240;
        _loginHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 240;

        _loginXOffset = 20;
        _registerYOffset = MediaQuery.of(context).viewInsets.bottom!=0 ? 140 : 260;
        _registerHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 240;
        break;
    }

    return Scaffold( //?Added after error -'No Material Widget' Later showing widget overflowing on login screen
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                _pageState=0;
              });
            },
            child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(
                    milliseconds: 1000
                ),
                color: _backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 0;
                        });
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            AnimatedContainer(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: Duration(
                                  milliseconds: 1000
                              ),
                              margin: EdgeInsets.only(
                                top: _headingTop,
                              ),
                              child: Text(
                                "Green Earth",
                                style: TextStyle(
                                    color: _headingColor,
                                    fontSize: 28
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32
                              ),
                              child: Text(
                                "My waste ,My responsibility!!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _headingColor,
                                    fontSize: 16
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32
                      ),
                      child: Center(
                      child: Image.asset("assets/images/imageedit_1_4188329228.png"),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if(_pageState != 0){
                              _pageState = 0;
                            } else {
                              _pageState = 1;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF29a329),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(32),
            width: _loginWidth,
            height: _loginHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
                milliseconds: 1000
            ),
            transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(_loginOpacity),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                )
            ),
            // child: Column(
            //   children: <Widget>[
                child:Form(
                  key: formkey1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Login To Continue",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                      EmailWithIcon(
                        icon: Icons.email,
                        hint: "Enter Email",
                        keyboard: TextInputType.emailAddress,
                        emailController: loginUsernameController,
                      ),
                      PasswordWithIcon(
                        icon: Icons.vpn_key,
                        hint: "Enter Password",
                        keyboard: TextInputType.text,
                        passwordController: loginPasswordController,
                      ),
                      GestureDetector(
                        onTap:() async {
                          if(formkey1.currentState.validate()==true){
                            loginUsername=loginUsernameController.text;
                            loginPassword=loginPasswordController.text;
                            setState(() {
                              _isloading=true;
                            });
                            var status=await attemptLogIn(loginUsername, loginPassword, context);
                            if(status==200){
                              setState(() {
                                Fluttertoast.showToast(msg: "Logged in!!",toastLength: Toast.LENGTH_SHORT);
                                _isloading=false;
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainPageDrawer("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDY0MTBmZjZmZTNlYTAwMDQ0MGM0MjkiLCJpYXQiOjE2MTcyMDg3Njh9.LvnMyNMZKcuL4kjIVuh4aerNnjtFK5lNLO0RtveGhhI")));
                              });
                            }
                            else{
                              setState(() {
                                _isloading=false;
                              });
                              _showMyDialoglogin(context, status);
                            }
                          }
                        },
                        child: PrimaryButton(
                          btnText: "Login",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageState = 2;
                          });
                        },
                        child: OutlineBtn(
                          btnText: "Create New Account",
                        ),
                      )
                    ],
                  ),
                ),
                // Column(
                //   children: <Widget>[
                //
                //   ],
                // ),

          ),
          AnimatedContainer(
            height: _registerHeight,
            padding: EdgeInsets.all(32),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
                milliseconds: 1000
            ),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                )
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
                child:Form(
                  key: formkey2,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Create a New Account",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                    UsernameWithIcon(
                      icon: Icons.account_circle_sharp,
                      hint: "Enter Username",
                      nameOfUserController: signupNameOfUserController,
                    ),
                    EmailWithIcon(
                      icon: Icons.email,
                      hint: "Enter Email",
                      keyboard: TextInputType.emailAddress,
                      emailController: signupUsernameController,
                    ),
                    PasswordWithIcon(
                      icon: Icons.vpn_key,
                      hint: "Enter Password",
                      keyboard: TextInputType.text,
                      passwordController: signupPasswordController,
                    ),
                    GestureDetector(
                      onTap:() async {
                        if(formkey2.currentState.validate()==true){
                          signupUsername=signupUsernameController.text;
                          signupPassword=signupPasswordController.text;
                          nameOfUser=signupNameOfUserController.text;
                          setState(() {
                            _isloading=true;
                          });
                          await attemptSignUp(signupUsername, signupPassword,nameOfUser,context);
                          setState(() {
                            _isloading=false;
                          });
                        }
                      },
                      child: PrimaryButton(
                        btnText: "Create Account",
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 1;
                        });
                      },
                      child: OutlineBtn(
                        btnText: "Back To Login",
                      ),
                    )
                  ],
                ),
                ),
                // Column(
                //   children: <Widget>[
                //   ],
                // ),
            //   ],
            // ),
          ),
          !_isloading?SizedBox.shrink():Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
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
}