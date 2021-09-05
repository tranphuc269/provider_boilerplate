part of swagger.api;

class LoginRequestAuth {
  String userName;
  String password;

  LoginRequestAuth();

  @override
  String toString() {
    return 'LoginRequestAuth[loginId=$userName, password=$password, ]';
  }

  LoginRequestAuth.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userName = json['login_id'];
    password = json['password'];

  }

  Map<String, dynamic> toJson() {
    return {'login_id': userName, 'password': password,};
  }

  static List<LoginRequestAuth> listFromJson(List<dynamic> json) {
    return json == null
        ? <LoginRequestAuth>[]
        : json.map((value) => new LoginRequestAuth.fromJson(value)).toList();
  }

  static Map<String, LoginRequestAuth> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, LoginRequestAuth>{};
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new LoginRequestAuth.fromJson(value));
    }
    return map;
  }
}
