import 'dart:async';
import 'dart:io';

import 'package:green_earth/Confetties/SubmitLoadingPage.dart';
import 'package:green_earth/Confetties/confetti.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:green_earth/News/Article.dart';
import 'package:green_earth/News/ListTileDesign.dart';
import 'package:green_earth/json_convertors/calendarDates.dart';
import 'package:green_earth/service/mainPage_combineRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:green_earth/parent_inherit.dart';
import 'package:green_earth/Home Page/background.dart';
import 'package:green_earth/service/connectionCheck.dart';
import 'package:green_earth/service/login_signup_Auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:green_earth/Home Page/calender class.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:green_earth/NavigatingPages/leaderboard.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class MainPage extends StatefulWidget {
  final String token;
  MainPage(this.token);
  @override
  _MainPageState createState() => _MainPageState();
}

enum AniProps { width, backgroundcolor, opacity,childIndex }
var successfulUploadedDate;
class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  final durationPart1 = const Duration(milliseconds: 400);
  final durationPart1a = const Duration(milliseconds: 200);
  final durationPart1b = const Duration(milliseconds: 200);
  final durationPart2 = const Duration(milliseconds: 400);


  final tween1 = MultiTween<AniProps>()
    ..add(AniProps.width, Tween(begin: 200.0, end: 50.0),
        Duration(milliseconds: 400))..add(AniProps.childIndex, ConstantTween(0),
        Duration(milliseconds: 400))..add(AniProps.childIndex, ConstantTween(1),
        Duration(milliseconds: 200))..add(
        AniProps.opacity, Tween(begin: 1.0, end: 0.0),
        Duration(milliseconds: 200))..add(
        AniProps.opacity, Tween(begin: 0.0, end: 1.0),
        Duration(milliseconds: 200));


  Future<List<dynamic>> _future;
  double xOffset = 0;
  double yOffset = 0;
  var image;
  PickedFile myImage;
  String name;

  bool _startedLoading = false;
  bool _firstAnimationFinished = false;
  bool _dataAvailable = false;

  String token;
  double gaugeCounter = 0.0;

  bool isDrawerOpen = false;
  AnimationController controller;
  Animation<double> scaleAnimation;
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _listenToAnimationFinished(status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _firstAnimationFinished = true;
      });
    }
  }

  Widget showDialogBox(BuildContext context) {
    controller.forward();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ScaleTransition(
            scale: scaleAnimation,
            child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                title: new Text("No Internet Connection"),
                content:
                new Text("Check your Internet connection and Try Again!!"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        if (await internetChecker(context) == true) {
                          print("---------token in dialog::$token");
                          _future = getMultipleData(token);
                          setState(() {});
                        } else {
                          Navigator.of(context).pop();
                          showDialogBox(context);
                        }
                      },
                      child: new Text("Try Again"))
                ]),
          );
        });
  }

  Future<List<dynamic>> getMultipleData(String token) async {
    bool value = await DataConnectionChecker().hasConnection;
    if (value) {
      try {
        var value = [];
        var res1 = response1(token);
        var res2 = response2();
        var results = await Future.wait([res1, res2]); // list of Responses
        for (var response in results) {
          print(response.statusCode);
          print('#################${response.body}######################');
          if (response.statusCode == 200) {
            value.add(json.decode(response.body));
          }
        }

        return dataFilter(value);
      } on SocketException catch (e) {
        print(e);
      }
    } else {
      showDialogBox(context);
    }
  }

  List dataFilter(List value) {
    List<CalendarDates> calendarDates = [];
    List<Article> news = [];

    for (var val1 in value[0]["postDates"]) {
      CalendarDates singleData = CalendarDates.fromJson(val1);
      calendarDates.add(singleData);
    }
    print("~````````${value[1]}");
    if (value[1]['status'] == "ok") {
      value[1]["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null &&
            element['publishedAt'] != null && element['title'] != null &&
            element['content'] != null) {
          Article article = Article(
            publishedAt: element['publishedAt'],
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }

    print("---------------${value[0]["postDates"]}---------------");
    value[0] = calendarDates;
    value[1] = news;
    print('[[[[[[[[[[[[**************${calendarDates.length}************]]]]]');
    return value;
  }

  Future<http.Response> response2() {
    String url =
        "https://newsapi.org/v2/everything?q=climate-change&from=2021-03-30&sortBy=popularity&apiKey=1a65d99acf11472fb32c9e0ba5bb3b7b";

    return http.get(url);
  }

  Future<http.Response> response1(String token) {
    return http.get("https://green-earth.herokuapp.com/user",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + '$token'
        });
  }

  @override
  void initState() {
    super.initState();
    internetChecker(context);
    _future = getMultipleData(widget.token);
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    listener.cancel();
    controller.dispose();
    super.dispose();
  }

  Future<List<dynamic>> getRefreshedData(String token) async {
    List<dynamic> value = await getMultipleData(token);
    print("^^^^^^^^^${value}^^^^^^^^^^^");
    setState(() {});
    return value;
  }

  Future<bool> internetChecker(BuildContext context) async {
    if (await DataConnectionChecker().hasConnection) {
      return true;
    } else {
      InternetStatus = "You are disconnected to the Internet. ";
      contentmessage = "Please check your internet connection";
      showDialogBox(context);
      return false;
    }
  }

  Widget successfulPage;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Your Image'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(File(image.path)),
                      ),
                    ),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.clear_rounded),
                                Text('Cancel'),
                              ],
                            ),
                            color: Colors.white,
                            textColor: avtar_backGround1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(width: 0.1)),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SubmitLoadingPage(myImage, token)));
                              print("##############134");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.upload_rounded),
                                Text('Submit'),
                              ],
                            ),
                            color: avtar_backGround1,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(width: 0.1)),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        );
      },
    );
  }

  void displayBottomCameraMenu(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            child: new Container(
                decoration: new BoxDecoration(
                    color: avtar_backGround1,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: new Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          //  width: 400,
                          //  height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Upload Photo",
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    wordSpacing: 1.0),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.grey[200],
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        GestureDetector(
                          onTap: () async {
                            image = await ImagePicker()
                                .getImage(source: ImageSource.camera);
                            print(
                                "------------------------------------------------------------------------");
                            print(image);
                            print(
                                "------------------------------------------------------------------------");
                            //  viewModel.setImage(File(image.path));
                            //     print(viewModel.image);

                            print(
                                "------------------------------------------------------------------------");

                            myImage = image;
                            print('xxxxxxxxxxxxxxxxxxxxxx$myImage');
                            print('xxxxxxxxxxxxxxxxxxxxxx$image');
                            Navigator.pop(context);

                            _showMyDialog();
                          },
                          child: Container(
                            width: 400,
                            height: 60,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                unclickedColor.withOpacity(0.4),
                                child: Center(
                                  child: Icon(
                                    Icons.cloud_upload_outlined,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ),
                              title: Text("Click Image",
                                  style: TextStyle(
                                      color: Colors.grey[200],
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                      wordSpacing: 1.0)),
                            ),
                            decoration: BoxDecoration(
                              //      color: Colors.greenAccent,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            image = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            print(
                                "------------------------------------------------------------------------");
                            print(image);
                            print(
                                "------------------------------------------------------------------------");
                            //viewModel.setImage(File(image.path));
                            //   print(viewModel.image);

                            myImage = image;
                            print('xxxxxxxxxxxxxxxxxxxxxx$myImage');
                            print('xxxxxxxxxxxxxxxxxxxxxx$image');
                            Navigator.pop(context);

                            _showMyDialog();
                          },
                          child: Container(
                            width: 400,
                            height: 60,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                unclickedColor.withOpacity(0.4),
                                child: Center(
                                  child: Icon(
                                    Icons.drive_folder_upload,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ),
                              title: Text("From Gallery",
                                  style: TextStyle(
                                      color: Colors.grey[200],
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                      wordSpacing: 1.0)),
                            ),
                            decoration: BoxDecoration(
                              //      color: Colors.greenAccent,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  void alreadyUploadedMsg(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return Center(
            child: AlertDialog(
              content: SingleChildScrollView(
                child: ListTile(
                  leading: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                  title: Text(
                    "Already Submitted",
                    style: TextStyle(
                        letterSpacing: 0.8,
                        color: cool,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "You already submitted your today's image. Thanks!",
                      // style: TextStyle(
                      //     color: cool, fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // actions: <Widget>[
              //   TextButton(
              //     child: Text('Okay'),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    token = parent_inherit.of(context).token;
    name =parent_inherit.of(context).name;
    initializeDateFormatting('az');
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(() {
            xOffset = 0;
            yOffset = 0;
            isDrawerOpen = false;
          });
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (details.delta.dx > 0) {
            setState(() {
              xOffset = 290;
              yOffset = 80;
              isDrawerOpen = true;
            });
          } else {
            setState(() {
              xOffset = 0;
              yOffset = 0;
              isDrawerOpen = false;
            });
          }
        },
        child: AnimatedContainer(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [backGround, backGround],
                stops: [0.0, 1.0],
              ),
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(28.0)
                  : BorderRadius.circular(0.0),
            ),
            duration: Duration(milliseconds: 500),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(isDrawerOpen ? 0.85 : 1.00)
              ..rotateZ(isDrawerOpen ? -50 : 0),
            child: SafeArea(
              child: Stack(children: [
                circleDraw(),
                RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () => _future = getRefreshedData(token),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      isDrawerOpen
                                          ? IconButton(
                                        icon: Icon(Icons.arrow_back_ios),
                                        color: Colors.grey[200],
                                        iconSize: 33.0,
                                        onPressed: () {
                                          setState(() {
                                            xOffset = 0;
                                            yOffset = 0;
                                            isDrawerOpen = false;
                                          });
                                        },
                                      )
                                          : IconButton(
                                        icon: Icon(Icons.menu),
                                        color: Colors.grey[200],
                                        iconSize: 33.0,
                                        onPressed: () {
                                          setState(() {
                                            xOffset = 290;
                                            yOffset = 80;
                                            isDrawerOpen = true;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Stack(
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(Icons.notifications,
                                                  color: Colors.white,
                                                  size: 33.0),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LeaderBoard()));
                                              }),
                                          Positioned(
                                            right: 3,
                                            child: Container(
                                              padding: EdgeInsets.all(1),
                                              decoration: new BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                BorderRadius.circular(6),
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 12,
                                                minHeight: 12,
                                              ),
                                              child: Text(
                                                '2',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Hello! '+name,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              buildFutureBuilder(),
                            ],
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    margin: EdgeInsets.only(right: 10.0, bottom: 8.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        successfulUploadedDate == DateFormat('yyyy-MM-dd')
                            .format(DateTime.now()) ? alreadyUploadedMsg(
                            context) :
                        displayBottomCameraMenu(context);
                      },
                      shape: new CircleBorder(),
                      elevation: 0.0,
                      fillColor: Colors.teal[900],
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white70,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ]),
            )),
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

  FutureBuilder<List> buildFutureBuilder() {
    return FutureBuilder<List>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(
              '---------+++++++++++++${snapshot.data}++++++------------------');
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
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                DateIndicator(
                  datesResultList: snapshot.data[0],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Stack(children: <Widget>[
                  Container(
                    height: 290,
                    child: Container(
                      margin: EdgeInsets.only(left: 54, right: 54),
                      child: SizedBox(
                        height: 270.0,
                        child: BuildSfRadialGauge(gaugeCounter),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                '3',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Color(0xffB6EFAC)),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Position',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    color: Color(0xffB6EFAC)),
                              ),
                            ],
                          ),
                          Container(
                            width: 0.6,
                            height: 50.0,
                            color: Colors.grey,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  '10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: Color(0xffB6EFAC)),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  'Streak',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                      color: Color(0xffB6EFAC)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.6,
                            height: 50.0,
                            color: Colors.grey,
                          ),
                          Column(
                            children: [
                              Text(
                                '180',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Color(0xffB6EFAC)),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Score',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    color: Color(0xffB6EFAC)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'NEWS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Color(0xffDAE3D1)),
                      ),
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   setState(() {
                      //     gaugeCounter++;
                      //   });
                      // },
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.only(
                            top: 2.0, left: 10.0, right: 10.0),
                        child: ListView.builder(
                            itemCount: snapshot.data[1].length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Hero(
                                tag: "Different" + index.toString(),
                                child: NewsTile(
                                  index: index.toString(),
                                  imgUrl: snapshot.data[1][index].urlToImage ??
                                      "",
                                  title: snapshot.data[1][index].title ?? "",
                                  desc: snapshot.data[1][index].description ??
                                      "",
                                  content: snapshot.data[1][index].content ??
                                      "",
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 100.0),
              height: 60.0,
              width: 60.0,
              alignment: Alignment.center,
              child: Center(
                  child: Image.asset(
                    "assets/images/nama_loading_200px.gif",
                    fit: BoxFit.fill,
                  )),
            );
          }
        }
      //   else{
      //      return showDialogBox('No Internet Connection', 'Check your Internet Connection and Try Again!!', context);
      //   }
      // }
    );
  }

}

class BuildSfRadialGauge extends StatefulWidget {
  final double gaugeCounter;
  BuildSfRadialGauge(this.gaugeCounter);
  @override
  _BuildSfRadialGaugeState createState() => _BuildSfRadialGaugeState();
}

class _BuildSfRadialGaugeState extends State<BuildSfRadialGauge> {
  void onvalueChanged(double value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            startAngle: 150,
            endAngle: 30,
            axisLineStyle: AxisLineStyle(
              thickness: 28,
              color: Color(0xff1E524B),
            ),
            minimum: 0,
            maximum: 50,
            interval: 7,
            tickOffset: 10,
            minorTickStyle: MinorTickStyle(length: 0),
            pointers: <GaugePointer>[
              RangePointer(
                  value: 10,
                  width: 28,
                  gradient: const SweepGradient(
                    colors: <Color>[Color(0xFFB6EFAC), Color(0xFF94B68F)],
                  )),
              NeedlePointer(
                onValueChanged: onvalueChanged,
                value: 10,
                knobStyle: KnobStyle(
                    borderColor: Color(0xff1E524B),
                    borderWidth: 0.10,
                    knobRadius: 0.11,
                    color: Color(0xff94B68F)),
                enableAnimation: true,
                needleColor: Color(0xffB6EFAC),
                needleEndWidth: 8,
                needleStartWidth: 4,
              )
            ]),
      ],
    );
  }
}
