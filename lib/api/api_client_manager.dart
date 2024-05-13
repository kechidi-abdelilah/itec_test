import 'package:dio/dio.dart';

import 'api_client.dart';

class ApiClientManager {
  static final ApiClientManager _instance = ApiClientManager._internal();

  factory ApiClientManager() {
    return _instance;
  }

  ApiClientManager._internal();

  final Map<String, ApiClient> _clients = {};

  ApiClient getApiClient(String baseUrl, bool isLogin) {
    String key = "$baseUrl-$isLogin";
    if (!_clients.containsKey(key)) {
      var dio = Dio(); // You might want to configure this Dio instance as needed
      _clients[key] = ApiClient(baseUrl, dio, isLogin: isLogin);
    }
    return _clients[key]!;
  }
}