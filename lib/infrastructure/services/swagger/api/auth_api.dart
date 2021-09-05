part of swagger.api;

class AuthApi {
  final ApiClient apiClient;

  AuthApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  /// Login
  ///
  Future<AuthCreate> apiV1AuthPost(LoginRequest body) async {

    // verify required params are set
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    final String path = "/api/v1/auth".replaceAll("{format}", "json");

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};

    const String contentType = "application/json";
    final List<String> authNames = [];

    final response = await apiClient.invokeAPI(path, 'POST', queryParams,
        body, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'AuthCreate') as AuthCreate;
    } else {
      return null;
    }
  }
}
