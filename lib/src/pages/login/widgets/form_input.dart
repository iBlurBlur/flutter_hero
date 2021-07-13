import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormInput extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  final String? errorUsername;
  final String? errorPassword;

  const FormInput({
    Key? key,
    required this.usernameController,
    required this.passwordController,
     this.errorUsername,
     this.errorPassword,
  }) : super(key: key);

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  static const _color = Colors.black54;

  static const _inputStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    color: _color,
  );

  bool _obscureTextPassword = true;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildUsername(),
        Divider(
          height: 22,
          thickness: 1,
          indent: 13,
          endIndent: 13,
        ),
        _buildPassword(),
      ],
    );
  }

  TextFormField _buildUsername() => TextFormField(
        controller: widget.usernameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Email Address',
          labelStyle: _inputStyle,
          hintText: 'iblurblur@dev.com',
          icon: Icon(
            FontAwesomeIcons.envelope,
            color: _color,
            size: 22.0,
          ),
          errorText: widget.errorUsername,
        ),
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
      );

  TextFormField _buildPassword() {
    return TextFormField(
      controller: widget.passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Password',
        labelStyle: _inputStyle,
        icon: Icon(
          FontAwesomeIcons.lock,
          size: 22.0,
          color: _color,
        ),
        suffixIcon: IconButton(
          onPressed: _togglePassword,
          icon: Icon(
            _obscureTextPassword
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash,
            size: 15.0,
            color: _color,
          ),
        ),
        errorText: widget.errorPassword,
      ),
      obscureText: _obscureTextPassword,
    );
  }

  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
