import 'package:flutter/material.dart';
import 'package:flutter_hero/src/pages/home/widgets/report.dart';
import 'package:flutter_hero/src/pages/home/widgets/stock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabMenu {
  final String title;
  final IconData? icon;
  final Widget child;

  const TabMenu(
    this.title,
    this.child, {
    this.icon,
  });
}

class TabMenuViewModel {
  List<TabMenu> get items => <TabMenu>[
        TabMenu(
          'Stock',
          Stock(),
          icon: FontAwesomeIcons.box,
        ),
        TabMenu(
          'Report',
          Report(),
          icon: FontAwesomeIcons.fileAlt,
        ),
        TabMenu(
          'Chart',
          FlutterLogo(
            size: 100,
            style: FlutterLogoStyle.horizontal,
          ),
          icon: FontAwesomeIcons.chartArea,
        ),
      ];
}
