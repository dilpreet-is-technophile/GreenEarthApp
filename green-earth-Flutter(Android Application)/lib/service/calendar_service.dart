import 'package:flutter/material.dart';
import 'package:green_earth/json_convertors/leaderboardData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> calendarPostDates (BuildContext context,String token) async {
  print('');
  print('!!!!!!!!!!!!!!');
  print(token);
  print('!!!!!!!!!!!!!!');
  print('');
  try {
    final http.Response res = await http.get(
        "https://green-earth.herokuapp.com/user",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + '$token'
        }
    );
    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);

      print('');
      print("&&&&&&&&&&& $jsonData");
      print('');
      return jsonData['postDates'];
      //   print(leaderboardList);
      //   return leaderboardList;
    }
  }
  catch(e) {
    print('');
    print('');
    print('Data not fetched');
    print('');
    print('');
    }
}
