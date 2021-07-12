import 'package:flutter/material.dart';

class LoginDivider extends StatelessWidget {
  final colorLine = const [Colors.white10, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildLineGradient(colorLine),
        _buildText(),
        _buildLineGradient(colorLine.reversed.toList()),
      ],
    );
  }

  Container _buildLineGradient(List<Color> colors) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        width: 100.0,
        height: 1.0,
      );

  Padding _buildText() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'or',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16.0,
          ),
        ),
      );
}
