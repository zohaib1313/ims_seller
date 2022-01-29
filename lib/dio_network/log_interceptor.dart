import 'package:dio/dio.dart';

import '../utils/utils.dart';

class LogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printWrapped(
        'METHOD: ${options.method} \nDATA: [${options.data}] \nURL: ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    printWrapped(
        'ERROR: ${dioError.response?.statusCode} \n Message: ${dioError.message} \n Data: ${dioError.response?.data}');
    return super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printWrapped(
        'RESPONSE: ${response.statusCode} \n Data: ${response.data} \n Data Length: ${response.data.length}');
    return super.onResponse(response, handler);
  }
}
