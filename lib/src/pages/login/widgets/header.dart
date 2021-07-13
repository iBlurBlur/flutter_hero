import 'package:flutter/material.dart';
import 'package:flutter_hero/src/constants/asset.dart';

class Header extends StatelessWidget {
  final double height;

  const Header(this.height);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Asset.logoImage,
      height: height,
    );
  }
}
