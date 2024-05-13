import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_2/models/ItemModel.dart';
import 'package:test_2/widgets/itemWidget.dart';

import '../constants.dart';
import 'api_client.dart';
import 'api_client_manager.dart';

class ApiRepository {
  ApiClient? apiClientLogin;
  ApiClient? apiClient;

  ApiRepository() {
    var dio = Dio();
    apiClient = ApiClientManager().getApiClient(BASEURL, false);
    apiClientLogin = ApiClientManager().getApiClient(BASEURL, true);
  }

  Future<ItemModel?> getItems() async {
    try {
      Map<String, dynamic> response = await apiClient!.get("products");
      return ItemModel.fromJson(response);
    } on DioError catch (e, stack) {
      debugPrint(
          "error when processing data response ${e.message}, stack is $stack");
      return null;
    }
  }
}
