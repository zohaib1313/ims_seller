import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api_response.dart';
import 'api_route.dart';
import 'cache.dart';
import 'decodable.dart';

abstract class BaseAPIClient {
  Future<ResponseWrapper<T>> request<T extends Decodable>({
    @required APIRouteConfigurable? route,
    @required Create<T> create,
  });
}

class APIClient implements BaseAPIClient {
  Dio? instance;
  bool isCache;
  String baseUrl;
  String contentType;
  bool isDialoigOpen;

  init() async {
    // String sha256  = 'KEZJOdneURbhMeANe+HVaw0mcmPp6zKFKr6jHc85o0E=';
    print("loading certificate");
    try {
      ByteData bytes =
          await rootBundle.load('assets/certification/salammobile-sa.pem');
      print("certificate bites= ${bytes}");
      (instance!.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        print("certificate added");
        SecurityContext sc = SecurityContext();
        sc.setTrustedCertificatesBytes(bytes.buffer.asUint8List());
        HttpClient httpClient = HttpClient(context: sc);
        return httpClient;
      };
    } catch (e) {
      print("Exceptionaa ${e}");
    }
  }

  APIClient(
      {this.isCache = true,
      this.baseUrl = ApiConstants.baseUrl,
      this.isDialoigOpen = true,
      this.contentType = 'application/json'}) {
    instance = Dio();
    init();
    if (instance != null) {
      instance!.interceptors.add(LogInterceptor());
      if (isCache) {
        List<String> allowedSHa = [];
        //   allowedSHa.add('KEZJOdneURbhMeANe+HVaw0mcmPp6zKFKr6jHc85o0E=');
        instance!.interceptors.add(DioCacheInterceptor(
            options: CacheOption(CachePolicy.forceCache).options));
        //  instance!.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: allowedSHa));
      } else {
        // instance!.interceptors.add(DioCacheInterceptor(options: CacheOption(CachePolicy.noCache).options));
      }
    }
  }

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
  };

  @override
  Future<ResponseWrapper<T>> request<T extends Decodable>({
    @required APIRouteConfigurable? route,
    @required Create<T>? create,
    Function? apiFunction,
  }) async {
    print(headers);

    final config = route!.getConfig();
    config.baseUrl = baseUrl;
    config.headers = headers;
    config.connectTimeout = 60000;
    config.receiveTimeout = 60000;
    config.followRedirects = false;
    config.validateStatus = (status) {
      return status! <= 500;
    };

    final response = await instance!.fetch(config).catchError((error) {
      // AppPopUps().dissmissDialog();
      // print("error in response ${error.toString()}");
      if ((error as DioError).type == DioErrorType.connectTimeout) {
        print('Connection TimeOut ${config.path}');

        throw error;
      }
    });

    final responseData = response.data;
    print('response CODE= ' + response.statusCode.toString());
    print('response data= ' + response.toString());
    int statusCode = response.statusCode!;

    switch (statusCode) {
      case 200:
      case 304:
        var finalResponse =
            ResponseWrapper.init(create: create, json: responseData);
        if (finalResponse.error != null) {
          print('this Error');
          final errorResponse = finalResponse.error!;

          throw errorResponse;
        } else {
          return ResponseWrapper.init(create: create, json: responseData);
        }
      default:
        final errorResponse = ErrorResponse.fromJson(responseData);
        throw errorResponse;
    }
  }
}
