const String apiServerUrl = "https://example.api";

enum HttpSetting {
  get,
  post,
  put,
  delete,
  patch,
  multipartRequest,
}

extension HttpSettingTimeout on HttpSetting {
  /// タイムアウト時間(秒)
  int get timeout {
    switch (this) {
      case HttpSetting.get:
        return 30;
      case HttpSetting.post:
        return 30;
      case HttpSetting.put:
        return 30;
      case HttpSetting.delete:
        return 30;
      case HttpSetting.patch:
        return 30;
      case HttpSetting.multipartRequest:
        return 30;
    }
    return -1;
  }
}
