import 'package:flutter/material.dart';
import 'package:flutter_hero/src/pages/login/background_theme.dart';

class FormButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const FormButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth * 0.6,
        height: 50,
        decoration: _boxDecoration(),
        child: _buildButton(),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    final gradientStart = BackgroundTheme.gradientStart;
    final gradientEnd = BackgroundTheme.gradientEnd;

    final boxShadowItem = (Color color) => BoxShadow(
      color: color,
      offset: Offset(1.0, 6.0),
      blurRadius: 20.0,
    );

    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      boxShadow: <BoxShadow>[
        boxShadowItem(gradientStart),
        boxShadowItem(gradientEnd),
      ],
      gradient: LinearGradient(
        colors: [
          gradientEnd,
          gradientStart,
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 1.0),
        stops: [0.0, 1.0],
      ),
    );
  }

  TextButton _buildButton() => TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.transparent),
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: onPressed,
      );
}
