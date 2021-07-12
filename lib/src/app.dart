import 'package:flutter/material.dart';
import 'package:flutter_hero/src/configs/routes/app_route.dart';
import 'package:flutter_hero/src/pages/login/login_page.dart';
import 'package:flutter_hero/src/utils/helpers/device.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoute().getAll,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) {
          Device(context);
          return LoginPage();
        },
      ),
    );
  }
}
