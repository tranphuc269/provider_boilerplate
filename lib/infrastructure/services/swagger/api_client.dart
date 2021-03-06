part of swagger.api;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {
  String basePath;
  BaseClient client;

  final Map<String, String> _defaultHeaderMap = {};
  final Map<String, Authentication> _authentications = {};

  final _regList = RegExp(r'^List<(.*)>$');
  final _regMap = RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath: apiServerUrl}) {
    _authentications["bearerAuth"] = OAuth(accessToken: "");
  }

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'AuthCreate':
          return AuthCreate.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _regList.firstMatch(targetType)) != null) {
              final newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _regMap.firstMatch(targetType)) != null) {
              final newTargetType = match[1];
              return Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    throw ApiException(
        500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    final type = targetType.replaceAll(' ', '');

    if (type == 'String') return jsonVal;

    final decodedJson = json.decode(jsonVal);
    assert(() {
      print(decodedJson.toString());
      return true;
    }());
    return _deserialize(decodedJson, type);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  Future<Response> invokeAPI(
      String path,
      String method,
      Iterable<QueryParam> queryParams,
      Object body,
      Map<String, String> headerParams,
      Map<String, String> formParams,
      String contentType,
      List<String> authNames) async {
    _updateParamsForAuth(authNames, queryParams, headerParams);

    final ps = queryParams
        .where((p) => p.value != null)
        .map((p) => '${p.name}=${p.value}');
    final String queryString = ps.isNotEmpty ? '?' + ps.join('&') : '';

    final String url = basePath + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if (body is MultipartRequest) {
      final request = MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      final response = await client
          .send(request)
          .timeout(Duration(seconds: HttpSetting.multipartRequest.timeout));
      return Response.fromStream(response);
    } else {
      final msgBody = contentType == "application/x-www-form-urlencoded"
          ? formParams
          : serialize(body);
      switch (method) {
        case "POST":
          return client
              .post(url, headers: headerParams, body: msgBody)
              .timeout(Duration(seconds: HttpSetting.post.timeout));
        case "PUT":
          return client
              .put(url, headers: headerParams, body: msgBody)
              .timeout(Duration(seconds: HttpSetting.put.timeout));

        case "DELETE":
          return client
              .delete(url, headers: headerParams)
              .timeout(Duration(seconds: HttpSetting.delete.timeout));

        case "PATCH":
          return client
              .patch(url, headers: headerParams, body: msgBody)
              .timeout(Duration(seconds: HttpSetting.patch.timeout));

        default:
          return client
              .get(url, headers: headerParams)
              .timeout(Duration(seconds: HttpSetting.get.timeout));
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames,
      List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      final Authentication auth = _authentications[authName];
      if (auth == null)
        throw new ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  void setAccessToken(String accessToken) {
    _authentications.forEach((key, auth) {
      if (auth is OAuth) {
        auth.setAccessToken(accessToken);
      }
    });
  }
}
