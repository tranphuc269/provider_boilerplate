part of swagger.api;

class AuthCreate {
  int id;
  String name;
  String avatarImageThumbUrl;
  String refreshToken;
  DateTime refreshTokenExpirationAt;
  String token;
  List<AllOfOfficeListIndexItems> offices = [];

  AuthCreate();

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'AuthCreate[id=$id, name=$name, avatarImageThumbUrl=$avatarImageThumbUrl, refreshToken=$refreshToken, refreshTokenExpirationAt=$refreshTokenExpirationAt, token=$token, offices=$offices, ]';
  }

  AuthCreate.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    avatarImageThumbUrl = json['avatar_image_thumb_url'];
    refreshToken = json['refresh_token'];
    refreshTokenExpirationAt = json['refresh_token_expiration_at'] == null
        ? null
        : DateTime.parse(json['refresh_token_expiration_at']);
    token = json['token'];
    offices = AllOfOfficeListIndexItems.listFromJson(json['offices']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_image_thumb_url': avatarImageThumbUrl,
      'refresh_token': refreshToken,
      'refresh_token_expiration_at': refreshTokenExpirationAt == null
          ? ''
          : refreshTokenExpirationAt.toUtc().toIso8601String(),
      'token': token,
      'offices': offices
    };
  }

  static List<AuthCreate> listFromJson(List<dynamic> json) {
    return json == null
        ? <AuthCreate>[]
        : json.map((value) => new AuthCreate.fromJson(value)).toList();
  }

  static Map<String, AuthCreate> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, AuthCreate>{};
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AuthCreate.fromJson(value));
    }
    return map;
  }
}
