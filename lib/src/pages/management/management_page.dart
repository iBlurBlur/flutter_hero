import 'package:flutter/material.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Management'),
      ),
      body: Center(
        child: FlutterLogo(size: 200,),
      ),
    );
  }
}
