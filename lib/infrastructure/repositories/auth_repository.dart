import 'package:flutter_provider_example/infrastructure/services/swagger/api.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'repository.dart';

class AuthRepository extends Repository {
  AuthRepository._(
    this._authApi,
    this._authTokenStorage,
  );

  /// singleton
  static AuthRepository _instance;
  factory AuthRepository({
    AuthApi authApi,
    AuthTokenStorage authTokenStorage,
  }) =>
      _instance ??= AuthRepository._(
        authApi ?? AuthApi(),
        authTokenStorage ?? AuthTokenStorage(),
      );

  final AuthApi _authApi;
  final AuthTokenStorage _authTokenStorage;

  /// Login
  Future<AuthenticationUser> login({
    String userName,
    String password,
  }) async {
    // Make a request
    final loginRequestAuth = LoginRequestAuth()
      ..userName = userName
      ..password = password;
    final loginRequest = LoginRequest()..auth = loginRequestAuth;

    // Perform login
    final _response = await _authApi.apiV1AuthPost(loginRequest);

    // オプション情報
    final decodeToken = JwtDecoder.decode(_response.token);
    final optionFood = decodeToken['canbright_member_claim']['option_food'];


    return AuthenticationUser(
      id: _response.id,
      name: _response.name,
      avatarImageUrl: _response.avatarImageUrl,
      avatarImageThumbUrl: _response.avatarImageThumbUrl,
      token: _response.token,
      refreshToken: _response.refreshToken,
      organization: organization,
      offices: offices,
    );
  }

  /// Log out
  Future<void> logout() async {
    try {
      final _token = await _authTokenStorage.getToken();

      if (_token == null) {
        throw GenericException(
          message: "Token does not exist",
          code: ExceptionCode.unauthorizedError,
        );
      }

      _authApi.apiClient.setAccessToken(_token);
      await _authApi.apiV1AuthDelete();
    } catch (e) {
      rethrow;
    } finally {
      _authTokenStorage.deleteToken();
      _authTokenStorage.deleteRefreshToken();
    }
  }


  /// Set token information
  Future<void> setToken(
    String token,
    String refreshToken,
  ) async {
    await _authTokenStorage.setToken(token);
    await _authTokenStorage.setRefreshToken(refreshToken);
  }

  /// Delete token information
  Future<void> deleteToken() async {
    await _authTokenStorage.deleteToken();
    await _authTokenStorage.deleteRefreshToken();
  }
}
