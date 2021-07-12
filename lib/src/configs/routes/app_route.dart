import 'package:flutter/material.dart';
import 'package:flutter_hero/src/pages/pages.dart';

class AppRoute {
  static const home = "home";
  static const login = "login";

  final _route = <String, WidgetBuilder>{
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
  };

  get getAll => _route;
}