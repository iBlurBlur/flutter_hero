import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_hero/src/constants/common.dart';

class Device {
  static bool isTablet = false;
  static String platform = Common.android;
  static double heightOfScreen = 0;
  static double widthOfScreen = 0;

  Device(BuildContext context) {
    final size = MediaQuery.of(context).size;
    heightOfScreen = size.height;
    widthOfScreen = size.width;

    if (widthOfScreen > 600) {
      isTablet = true;
    }

    if (kIsWeb) {
      platform = Common.web;
      return;
    }

    if (Platform.isIOS) {
      platform = Common.ios;
      return;
    }
  }
}
