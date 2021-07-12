import 'package:flutter/material.dart';
import 'package:flutter_hero/src/configs/routes/app_route.dart';
import 'package:flutter_hero/src/pages/home/home_page.dart';
import 'package:flutter_hero/src/pages/login/login_page.dart';
import 'package:flutter_hero/src/utils/helpers/device.dart';
import 'package:flutter_hero/src/utils/services/local_storage_service.dart';

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
          return _buildHomePage();
        },
      ),
    );
  }

  FutureBuilder _buildHomePage() => FutureBuilder<String>(
    future: LocalStorageService().getToken(),
    builder: (context, snapshot) {
      Device(context);

      if (!snapshot.hasData) {
        return Container(
          color: Colors.white,
        );
      }

      if(snapshot.data!.isNotEmpty){
        return HomePage();
      }
      return LoginPage();
    },
  );
}
