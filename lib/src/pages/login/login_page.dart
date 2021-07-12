import 'package:flutter/material.dart';
import 'package:flutter_hero/src/pages/login/background_theme.dart';
import 'package:flutter_hero/src/pages/login/widgets/header.dart';

// https://dart.dev/guides/language/effective-dart/style#do-name-import-prefixes-using-lowercase_with_underscores
import 'package:flutter_hero/src/pages/login/widgets/form.dart' as login;
import 'package:flutter_hero/src/pages/login/widgets/login_divider.dart';
import 'package:flutter_hero/src/pages/login/widgets/single_sign_on_button.dart';
import 'package:flutter_hero/src/utils/helpers/device.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildSpacing(0.07),
                Header(Device.heightOfScreen * 0.15),
                _buildSpacing(0.03),
                login.Form(),
                _buildSpacing(0.03),
                _buildTextButton(
                  'Forgot Password?',
                  onPressed: () {
                    //todo
                  },
                ),
                _buildSpacing(0.02),
                LoginDivider(),
                _buildSpacing(0.02),
                SingleSignOn(),
                _buildSpacing(0.04),
                _buildTextButton(
                  'Don’t have an Account ?',
                  onPressed: () {
                    //todo
                  },
                  fontSize: 13,
                ),
                _buildSpacing(0.05),
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox _buildTextButton(
    String text, {
    VoidCallback? onPressed,
    double fontSize = 16,
  }) =>
      SizedBox(
        width: 250,
        child: TextButton(
          style:  ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );

  Container _buildBackground() => Container(
        decoration: BoxDecoration(
          gradient: BackgroundTheme.gradient,
        ),
      );

  SizedBox _buildSpacing(double spacing) =>
      SizedBox(height: Device.heightOfScreen * spacing);
}
