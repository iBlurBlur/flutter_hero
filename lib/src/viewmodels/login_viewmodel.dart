import 'dart:async';

import 'package:flutter_hero/src/utils/helpers/regex_validator.dart';
import 'package:flutter_hero/src/utils/services/local_storage_service.dart';

class ValidateModel {
  String? errorUsername;
  String? errorPassword;
}

class LoginViewModel {
  final _loginController = StreamController<bool>();
  final _validateController = StreamController<ValidateModel>.broadcast();
  late final Stream<bool> loginStream;
  late final Stream<ValidateModel> validateStream;

  LoginViewModel() {
    loginStream = _loginController.stream;
    validateStream = _validateController.stream;
  }

  void dispose() {
    _loginController.close();
    _validateController.close();
  }

  Future<void> login(String username, String password) async {
    final validate = ValidateModel();
    if (!EmailSubmitRegexValidator().isValid(username)) {
      validate.errorUsername = "The Email must be a valid email.";
    }

    if (password.length < 8) {
      validate.errorPassword = 'Must be at least 8 characters.';
    }

    _validateController.sink.add(validate);
    if (validate.errorUsername != null || validate.errorPassword != null) {
      return;
    }

    await Future.delayed(Duration(seconds: 2));
    if (username != 'admin@gmail.com' || password != 'password') {
      _loginController.sink.add(false);
      return;
    }

    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImlCbHVyQmx1ciIsIm5hbWUiOiJpQmx1ckJsdXIiLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE1MTYyMzkwMjJ9.yAvjI0izXnHcM6DCY581pboWI0ObwSRRJadGVhaGYkA";
    await LocalStorageService().login(username, token);
    _loginController.sink.add(true);
  }
}
