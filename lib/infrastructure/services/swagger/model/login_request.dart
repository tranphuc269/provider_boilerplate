part of swagger.api;

class LoginRequest {
  LoginRequestAuth auth;

  LoginRequest();

  @override
  String toString() {
    return 'LoginRequest[auth=$auth, ]';
  }

  LoginRequest.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    auth = new LoginRequestAuth.fromJson(json['auth']);
  }

  Map<String, dynamic> toJson() {
    return {'auth': auth};
  }

  static List<LoginRequest> listFromJson(List<dynamic> json) {
    return json == null
        ? <LoginRequest>[]
        : json.map((value) => new LoginRequest.fromJson(value)).toList();
  }

  static Map<String, LoginRequest> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, LoginRequest>{};
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new LoginRequest.fromJson(value));
    }
    return map;
  }
}
