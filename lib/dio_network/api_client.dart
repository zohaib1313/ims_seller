import 'dart:async';
import 'dart:io' show Platform, exit;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/utils/utils.dart';

import 'APis.dart';
import 'api_response.dart';
import 'api_route.dart';
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
    // print("loading certificate");
    // try {
    //   ByteData bytes =
    //       await rootBundle.load('assets/certification/salammobile-sa.pem');
    //   print("certificate bites= ${bytes}");
    //   (instance!.httpClientAdapter as DefaultHttpClientAdapter)
    //       .onHttpClientCreate = (client) {
    //     print("certificate added");
    //     SecurityContext sc = SecurityContext();
    //     sc.setTrustedCertificatesBytes(bytes.buffer.asUint8List());
    //     HttpClient httpClient = HttpClient(context: sc);
    //     return httpClient;
    //   };
    // } catch (e) {
    //   print("Exceptionaa ${e}");
    // }
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
        // instance!.interceptors.add(DioCacheInterceptor(
        //     options: CacheOption(CachePolicy.forceCache).options));
        //  instance!.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: allowedSHa));
      } else {
        // instance!.interceptors.add(DioCacheInterceptor(options: CacheOption(CachePolicy.noCache).options));
      }
    }
  }

  Map<String, dynamic> headers = {
    'Authorization': 'Token 	614e83765257d5c98edf7bbb72958a4fd13e4519',
    'charset': 'utf-8'
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
      print("error in response ${error.toString()}");
      if ((error as DioError).type == DioErrorType.connectTimeout ||
          (error).type == DioErrorType.other) {
        AppPopUps.showAlertDialog(
            message: "Network is unreachable",
            onSubmit: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            });
        throw Future.value(error);
      }
    });

    final responseData = response.data;

    print('\n*****response CODE=*******\n' +
        response.statusCode.toString() +
        " \n******************\n");
    printWrapped('\n************response Data=***********\n' +
        response.data.toString() +
        " \n**************\n");

    int statusCode = response.statusCode!;

    switch (statusCode) {
      case 200:
      case 304:
        var finalResponse =
            ResponseWrapper.init(create: create, json: responseData);
        if (finalResponse.error != null) {
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
