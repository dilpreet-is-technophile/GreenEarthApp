import 'package:flutter/material.dart';
import 'package:green_earth/json_convertors/tokenClass.dart';

class LoginNotification extends Notification {
  final TokenClass token;

  LoginNotification(this.token);
}