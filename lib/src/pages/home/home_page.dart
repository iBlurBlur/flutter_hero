import 'package:flutter/material.dart';
import 'package:flutter_hero/src/pages/home/widget/custom_drawer.dart';
import 'package:flutter_hero/src/pages/home/widget/custom_tabbar.dart';
import 'package:flutter_hero/src/viewmodels/tab_menu_viewmodel.dart';

class HomePage extends StatelessWidget {
  final _tabs = TabMenuViewModel().items;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: _buildAppbar(),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: _tabs.map((item) => item.child).toList(),
        ),
      ),
    );
  }

  AppBar _buildAppbar() => AppBar(
    title: Text('Stock Workshop'),
    centerTitle: true,
    bottom: CustomTabBar(_tabs),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          //todo
        },
        icon: Icon(Icons.bookmark_border),
      ),
      IconButton(
        onPressed: () {
          //todo
        },
        icon: Icon(Icons.qr_code),
      ),
    ],
  );
}
