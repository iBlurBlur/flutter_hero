import 'package:flutter/material.dart';
import 'package:flutter_hero/src/configs/routes/app_route.dart';
import 'package:flutter_hero/src/pages/login/widgets/form_button.dart';
import 'package:flutter_hero/src/pages/login/widgets/form_input.dart';
import 'package:flutter_hero/src/viewmodels/login_viewmodel.dart';
import 'package:flutter_hero/src/widgets/custom_flushbar.dart';

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginViewModel = LoginViewModel();

  @override
  void initState() {
    _loginViewModel.loginStream.listen(_listenLogin);
    _loginViewModel.validateStream.listen(_listenValidate);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildForm(),
        FormButton(
          onPressed: () {
            _loginViewModel.login(
              _usernameController.text,
              _passwordController.text,
            );
          },
        ),
      ],
    );
  }

  Card _buildForm() {
    final double spaceOfButton = 22;
    final double space = 30;
    return Card(
      margin: EdgeInsets.only(bottom: spaceOfButton, left: space, right: space),
      elevation: 2.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 58,
          left: space,
          right: space,
        ),
        child: StreamBuilder<ValidateModel>(
          stream: _loginViewModel.validateStream,
          builder: (context, snapshot) {
            return FormInput(
              usernameController: _usernameController,
              passwordController: _passwordController,
              errorUsername: snapshot.data?.errorUsername,
              errorPassword: snapshot.data?.errorPassword,
            );
          },
        ),
      ),
    );
  }

  void _listenLogin(bool loginSuccess) {
    CustomFlushbar.close(context);
    if (!loginSuccess) {
      CustomFlushbar.showError(
        context,
        title: 'Username or Password is incorrect.',
        message: 'Please try again.',
      );
      return;
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => HomePage(),
    //   ),
    // );
    Navigator.pushReplacementNamed(context, AppRoute.home);
  }

  void _listenValidate(ValidateModel validate) {
    if (validate.errorUsername == null && validate.errorPassword == null) {
      CustomFlushbar.showLoading(context);
    }
  }
}
