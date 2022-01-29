import 'package:dio/dio.dart';

import 'APis.dart';

class APIRoute implements APIRouteConfigurable {
  final APIType? type;
  final String? routeParams;
  Map<String, dynamic>? headers;
  dynamic body;

  APIRoute(this.type, {this.routeParams, this.headers, this.body});

  /// Return config of api (method, url, header)
  @override
  RequestOptions getConfig() {
    // pass extra value to detect public or auth api

    switch (type) {
      case APIType.login:
        return RequestOptions(
          path: ApiConstants.loginUser,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );

      case APIType.searchCustomer:
        return RequestOptions(
          path: ApiConstants.searchCustomer,
          headers: headers,
          queryParameters: body,
          method: APIMethod.get,
        );
      case APIType.addCustomer:
        return RequestOptions(
          path: ApiConstants.addCustomer,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      default:
        return RequestOptions(
          path: ApiConstants.loginUser,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
    }
  }
}

abstract class APIRouteConfigurable {
  RequestOptions getConfig();
}

class APIMethod {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE'; //delete
}
