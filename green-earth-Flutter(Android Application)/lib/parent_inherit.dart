import 'package:flutter/material.dart';

import 'json_convertors/tokenClass.dart';

class parent_inherit extends InheritedWidget {
  final String token;
  final String name;
  final String email;
  final String score;
  final String avatarID;
  const parent_inherit({
    Key key,
    @required this.token,
    @required this.name,
    @required this.email,
    @required this.score,
    @required this.avatarID,
    Widget child})
      :super(key:key,child: child);

  @override
  bool updateShouldNotify(parent_inherit oldWidget) =>true;

  static parent_inherit of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<parent_inherit>();
}


//
// Widget tokenCorrector(String token){
//   print('');
//   print('&&&&&&&&&&&&&&&&');
//   print(token);
//   print('&&&&&&&&&&&&&');
//   print('');
//   String tokenCorrector=token;
//
//   return parent_inherit(token: tokenCorrector);
// }