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
      case APIType.searchMerchantInvoices:
        return RequestOptions(
          path: ApiConstants.searchMerchantInvoices,
          headers: headers,
          queryParameters: body,
          method: APIMethod.get,
        );
      case APIType.getInvoiceDetails:
        return RequestOptions(
          path: ApiConstants.getInvoiceDetails,
          headers: headers,
          queryParameters: body,
          method: APIMethod.get,
        );
      case APIType.getProductDetails:
        return RequestOptions(
          path: ApiConstants.getProductDetails,
          headers: headers,
          queryParameters: body,
          method: APIMethod.get,
        );
      case APIType.getPaymentMethods:
        return RequestOptions(
          path: ApiConstants.getPaymentMethods,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.getNotificationMethods:
        return RequestOptions(
          path: ApiConstants.getNotificationMethods,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.getSalesTarget:
        return RequestOptions(
          path: ApiConstants.getSalesTarget,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.getBankAccountsList:
        return RequestOptions(
          path: ApiConstants.getBankAccountsList,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.createInvoice:
        return RequestOptions(
          path: ApiConstants.createInvoice,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.sendNotifications:
        return RequestOptions(
          path: ApiConstants.sendNotifications,
          headers: headers,
          queryParameters: body,
          method: APIMethod.get,
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
