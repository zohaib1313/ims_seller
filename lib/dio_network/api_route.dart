import 'package:dio/dio.dart';

enum APIType { NOTIFICATIONLIST }

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
      case APIType.NOTIFICATIONLIST:
        return RequestOptions(
          path: ApiConstants.assignSimToUser,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      default:
        return RequestOptions(
          path: ApiConstants.assignSimToUser,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
    }
  }
}

class ApiConstants {
  static const baseUrl = "";
  static const assignSimToUser = '';
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
