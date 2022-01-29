import 'package:flutter/foundation.dart';

import 'decodable.dart';

typedef Create<T> = T Function();

abstract class GenericObject<T> {
  Create<Decodable>? create;

  GenericObject({this.create});

  T genericObject(dynamic data) {
    final item = create!();
    return item.decode(data);
  }
}

class ResponseWrapper<T> extends GenericObject<T> {
  T? response;
  ErrorResponse? error;

  ResponseWrapper({Create<Decodable>? create, this.error})
      : super(create: create);

  factory ResponseWrapper.init(
      {Create<Decodable>? create, Map<String, dynamic>? json}) {
    final wrapper = ResponseWrapper<T>(create: create);
    wrapper.response = wrapper.genericObject(json);

    if (wrapper.response is APIResponse) {
      if (kDebugMode) {
        print(wrapper.response.toString() + "this is response");
      }
      var finalResponse = wrapper.response as APIResponse;
      if (finalResponse.responseCode != '00' || finalResponse.status == '404') {
        if (kDebugMode) {
          print(wrapper.response.toString() + "this is response");
        }
        wrapper.error = ErrorResponse.fromJson(json!);
      }
    }
    return wrapper;
  }
}

class APIResponse<T> extends GenericObject<T>
    implements Decodable<APIResponse<T>> {
  String? responseCode;
  String? responseMessage;
  String? status;
  T? data;

  APIResponse({Create<Decodable>? create}) : super(create: create);

  @override
  APIResponse<T> decode(dynamic json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    status = json['status'] ?? '';
    data = (json as Map<String, dynamic>).containsKey('data')
        ? genericObject(json['data'])
        : null;
    return this;
  }
}

class APIListResponse<T> extends GenericObject<T>
    implements Decodable<APIListResponse<T>> {
  String? responseCode;
  String? responseMessage;
  String? status;
  List<T>? data;

  APIListResponse({Create<Decodable>? create}) : super(create: create);

  @override
  APIListResponse<T> decode(dynamic json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    status = json['status'] ?? '';
    data = [];
    json['data'].forEach((item) {
      data!.add(genericObject(item));
    });
    return this;
  }
}

class ErrorResponse implements Exception {
  String? message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        message: json['responseMessage'] ?? 'Something went wrong');
  }

  @override
  String toString() {
    return message!;
  }
}
