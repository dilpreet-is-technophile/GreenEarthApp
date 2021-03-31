import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_earth/parent_inherit.dart';
import '../service/leaderboard_service.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:math';

const Color avtar_backGround = Color(0xFF2FCB72);
const Color avtar_backGround1 = Color(0xFF0C3329);
const Color prof_Card = Color(0xFF196F3D);
const Color grade1 = Color(0xFF00b09b);
const Color grade2 = Color(0xFF96c93d);
const Color cool = Color(0xFF181A2F);
const clickedColor = Color(0xFF0C3329);
const unclickedColor = Color(0xFF196F3D);
Color probtn = Color(0xFF0C3329);
Color leadbtn = Color(0xFF196F3D);
Color gold = Color(0xFFD0B13E);
Color silver = Color(0xFF808080);
Color bronze = Color(0xFFA45735);

//Color list_item = Colors.grey[200];
bool userRank = false;

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


class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Widget _showDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("No Internet Connection"),
              content:
                  new Text("Check your Internet Connection and try again!!"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (await internetChecker(context) == true) {
                        setState(() {});
                      } else {
                        Navigator.of(context).pop();
                        _showDialog(context);
                      }
                    },
                    child: new Text("Try Again"))
              ]);
        });
  }

  @override
  void initState() {
    super.initState();
    internetChecker(context);
  }

  random(min, max){
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  Future<bool> internetChecker(BuildContext context) async {
    if (await DataConnectionChecker().hasConnection) {
      return true;
      // Future<bool>.value(true);
    } else {
      _showDialog(context);
      return false;
      // Future<bool>.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String token = parent_inherit.of(context).token;
    print('');
    print("LeaderBoard token = $token");
    print('');
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: cool,
            child: Card(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              elevation: 0,
              color: Colors.red,
              child: Container(
                padding: EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("3",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    CircleAvatar(
                      foregroundColor: Colors.green,
                      child: Align(
                        alignment: Alignment.bottomRight,
                      ),
                      backgroundImage:AssetImage(myAvatar[5]),
                      radius: 30,
                    ),
                    Text(
                      "John Doe",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "180",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: leaderBoardDataFetch(context, token),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              Widget newsListSliver;
              if (snapshot.hasError) {
                print("++++++++ ${snapshot.error}");
                // print("++++++++ ${snapshot.error}");
                // return Center(
                //   child: Text(
                //     '${snapshot.error} occured',
                //     style: TextStyle(fontSize: 18),
                //   ),
                // );
                newsListSliver = Center(
                    child: Text(
                      '${snapshot.error} occured',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
              }
              else if(snapshot.hasData){
                newsListSliver= SliverList(
                  delegate: SliverChildBuilderDelegate((context,index) {
                    return Container(
                      color: Colors.grey[200],
                      child: Card(
                        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        shadowColor: Colors.grey[200],
                        color: cardColorSelector(index),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${index+1}",
                                  style: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.bold)),
                              CircleAvatar(
                                foregroundColor: Colors.green,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                ),
                                backgroundImage:index==2?AssetImage(myAvatar[5]):AssetImage(myAvatar[random(1, 8)]),
                                radius: 20,
                              ),
                              Text(
                                "${snapshot.data[index].name}",
                                style:
                                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${snapshot.data[index].score}",
                                style:
                                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 6
                  )
                );
              }
              else{
                newsListSliver=SliverToBoxAdapter(child: Container(margin:EdgeInsets.only(top: 20.0),alignment:Alignment.center,child: CircularProgressIndicator()),);
              }
              return CustomScrollView(
                slivers: <Widget>[
                  buildSliverAppBar(),
                  newsListSliver
                ],
              );
            }
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
            backgroundColor: probtn,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 200.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Container(
                color: avtar_backGround1,
                height: 50,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Position",
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Score",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[leadbtn.withOpacity(0.5), cool])),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "LEADERBOARD",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      Icons.emoji_events_rounded,
                      color: gold,
                      size: 70,
                    ),
                  ],
                ),
              ),
            ),
            elevation: 9.0,
          );
  }

  Color cardColorSelector(int index) {
    if (index == 0) {
      return gold;
    } else if (index ==1) {
      return silver;
    } else if (index == 2) {
      return bronze;
    } else {
      return Colors.grey[300];
    }
  }
}
