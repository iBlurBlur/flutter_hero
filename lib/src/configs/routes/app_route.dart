import 'package:flutter/material.dart';
import 'package:flutter_hero/src/pages/pages.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const management = 'management';
  static const map = 'map';

  final _route = <String, WidgetBuilder>{
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    management: (context) => ManagementPage(),
    map: (context) => MapPage(),
  };

  get getAll => _route;
}