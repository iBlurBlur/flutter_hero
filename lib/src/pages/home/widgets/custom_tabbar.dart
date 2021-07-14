import 'package:flutter/material.dart';
import 'package:flutter_hero/src/viewmodels/tab_menu_viewmodel.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TabMenu> _tabs;

  const CustomTabBar(this._tabs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: _tabs
          .map((item) => Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      item.icon,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12),
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
