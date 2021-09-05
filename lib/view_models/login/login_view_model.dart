import 'package:flutter/material.dart';
import 'package:flutter_provider_example/app/login_app_service.dart';

import '../view_models.dart';

class LoginViewModel extends ViewModels {
  LoginViewModel(
    BuildContext context, {
    @required LoginAppService app,
  })  : _app = app,
        super(context);
  final LoginAppService _app;

  String userName = "";
  String password = "";

  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  set errorMessage(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      if (await isOnline()) {
        await _app.login(userName, password);

        Navigator.pushNamed(context, "/home");
      } else {
        errorMessage = "No internet";
        return;
      }
    } catch (e) {
      errorMessage = "error";
    }
  }
}
