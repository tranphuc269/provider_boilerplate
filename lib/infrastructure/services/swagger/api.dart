library swagger.api;

import 'dart:async';
import 'dart:convert';

import 'package:flutter_provider_example/config/api_config.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';


part 'api_client.dart';



part 'api/auth_api.dart';

part 'model/all_of_office_list_index_items.dart';
part 'model/auth_create.dart';
part 'model/login_request.dart';
part 'model/login_request_auth.dart';

ApiClient defaultApiClient = new ApiClient();
