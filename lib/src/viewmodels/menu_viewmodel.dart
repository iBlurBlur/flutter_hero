import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu {
  final String title;
  final IconData? icon;
  final Color iconColor;
  final Function(BuildContext context) navigator;

  const Menu(
    this.title, {
    required this.navigator,
    this.icon,
    this.iconColor = Colors.grey,
  });
}

class MenuViewModel {
  MenuViewModel();

  List<Menu> get items => <Menu>[
        Menu(
          'Profile',
          icon: FontAwesomeIcons.user,
          iconColor: Colors.deepOrange,
          navigator: (context) {
            //todo
          },
        ),
        Menu(
          'Dashboard',
          icon: FontAwesomeIcons.chartPie,
          iconColor: Colors.green,
          navigator: (context) {
            //todo
          },
        ),
        Menu(
          'InBox',
          icon: FontAwesomeIcons.inbox,
          iconColor: Colors.amber,
          navigator: (context) {
            //todo
          },
        ),
        Menu(
          'Map',
          icon: FontAwesomeIcons.map,
          iconColor: Colors.blue,
          navigator: (context) {
            //todo
          },
        ),
        Menu(
          'Settings',
          icon: FontAwesomeIcons.cogs,
          iconColor: Colors.blueGrey,
          navigator: (context) {
            //todo
          },
        ),
      ];
}
