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
    print("generic object ${wrapper.response}");

    wrapper.response = wrapper.genericObject(json);
    print("generic object ${wrapper.response}");

    if (wrapper.response is APIResponse) {
      var finalResponse = wrapper.response as APIResponse;
      if (finalResponse.status != true) {
        wrapper.error = ErrorResponse.fromJson(json!);
      }
    }
    return wrapper;
  }
}

class APIResponse<T> extends GenericObject<T>
    implements Decodable<APIResponse<T>> {
  String? responseMessage;
  bool? status;
  T? data;
  bool decoding = true;

  APIResponse({Create<Decodable>? create, this.decoding = true})
      : super(create: create);

  @override
  APIResponse<T> decode(dynamic json) {
    responseMessage = json['message'] ?? '';
    status = json['status'] ?? false;

    if (decoding && (status == true)) {
      data = ((json as Map<String, dynamic>).containsKey('data'))
          ? genericObject(json['data'])
          : null;
    }
    return this;
  }
}

class APIListResponse<T> extends GenericObject<T>
    implements Decodable<APIListResponse<T>> {
  String? responseMessage;
  bool? status;
  List<T>? data;

  APIListResponse({Create<Decodable>? create}) : super(create: create);

  @override
  APIListResponse<T> decode(dynamic json) {
    responseMessage = json['message'] ?? '';
    status = json['status'] ?? false;
    data = [];

    if (json['data'] != null) {
      json['data'].forEach((item) {
        data!.add(genericObject(item));
      });
    }
    return this;
  }
}

class ErrorResponse implements Exception {
  String? message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(message: json['message'] ?? 'Something went wrong');
  }

  @override
  String toString() {
    return message!;
  }
}
