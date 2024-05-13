// ignore_for_file: unused_element

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



import '../main.dart';


const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class ApiClient {
  final String baseUrl;
  Dio? _dio;
  final List<Interceptor>? interceptors;
  bool isLogin ;






  Future<RequestOptions> requestInterceptor(RequestOptions options) async {



    //options.headers.addAll({"Token": "$token${DateTime.now()}"});

    return options;
  }

  bool _isValidRefreshToken(DioError error) {
    log("error response data checking id is map");
    if (error.response?.data is! Map) return true;
    Map<String, dynamic>? r = error.response?.data;
    log("error response data is $r");
    if (r?.containsKey("error") == true) {
      if (r?["error"] == "invalid_request") return false;
    }
    return true;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio!.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  ApiClient(this.baseUrl, Dio? dio, {this.interceptors,required this.isLogin}) {
    _dio = dio ?? Dio();
    _dio!
      ..options.baseUrl = baseUrl
    //..options.connectTimeout = _defaultConnectTimeout
    //  ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
      };
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        RequestOptions r = await requestInterceptor(options);
        log("request options ${r.baseUrl}");
        return handler.next(r);
      },
      onError: (error, handler) async {
        log("error token $error");
        handler.reject(error);
        if (error.response?.statusCode == 401) {
          print("is login $isLogin");
          debugPrint("Unauthorized - Attempting token refresh");

          // Redirect to login if token refresh fails
        }
      },
    ));
    if (interceptors != null) {
      if (interceptors!.isNotEmpty) {
        _dio!.interceptors.addAll(interceptors!);
      }
    }
    //if (kDebugMode) {
    _dio!.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false));
    //}
  }

  Future<dynamic>? get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      debugPrint('socket error $e');
      rethrow; //SocketException(e.toString());
    } on FormatException catch (_) {
      debugPrint('format exception, $_');
      throw const FormatException("Unable to process the data");
    } on DioError catch (dio, stackTrace) {
      /*if (dio.type == DioErrorType.connectTimeout) {
        throw Exception("Connection timeout, please check your internet connection");
      }*/
      debugPrint('dio error ${dio.response}');
      debugPrint('dio error stack trace$stackTrace');
      rethrow;
    } catch (e) {
      //print('not DIO Error ' + _dio!.options.baseUrl + uri);
      rethrow;
    }
  }

  Future<dynamic> post(
      String? uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.post(
        uri!,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response?.data; //.data
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } on DioError catch (e) {
      debugPrint("dio error when posting data response $e");
      rethrow;
    } catch (e) {
      debugPrint("error when posting data response ${e.toString()}");
      rethrow;
    }
  }

  Future<dynamic> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response?.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response?.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response?.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }


}
