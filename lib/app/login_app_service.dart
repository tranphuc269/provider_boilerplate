import 'package:flutter_provider_example/infrastructure/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

import 'application.dart';

class LoginAppService extends Application {
  LoginAppService(Locator read) : super(read);

  AuthRepository get _authRepository => read<AuthRepository>();


  Future<void> login(
    String userName,
    String password,
  ) async {
    try {
      await _authRepository.deleteToken();

      final authenticationUser = await _authRepository.login(
        userName: userName,
        password: password,
      );

      // Save token to local
      await _authRepository.setToken(
        authenticationUser.token,
        authenticationUser.refreshToken,
      );


    } catch (e) {
      throw GenericException.handler(e);
    }
  }
}
