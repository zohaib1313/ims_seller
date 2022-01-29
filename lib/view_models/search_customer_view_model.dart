import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ims_seller/dio_network/APis.dart';
import 'package:ims_seller/dio_network/api_client.dart';
import 'package:ims_seller/dio_network/api_response.dart';
import 'package:ims_seller/dio_network/api_route.dart';
import 'package:ims_seller/dio_network/error_mapper.dart';
import 'package:ims_seller/models/search_result_model.dart';
import 'package:ims_seller/utils/utils.dart';

class SearchCustomerViewModel extends ChangeNotifier {
  TextEditingController searchTextEditingController = TextEditingController();

  StreamController<List<SearchResultModel>> streamController =
      StreamController.broadcast();

  Stream<List<SearchResultModel>> getSearchResult() {
    String phone = '';

    phone = '959${searchTextEditingController.text.toString()}';

    Map<String, dynamic> body = {"phone": phone};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.searchCustomer,
              body: body,
            ),
            create: () => APIResponse<SearchResultModelList>(
                create: () => SearchResultModelList()),
            apiFunction: getSearchResult)
        .then((response) {
      if (response.response!.data != null) {
        // searchListStreamController.sink.add(response.response!.data!);
        //notifyListener3s();
        streamController.sink.add(response.response!.data!.searchResultList);
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      streamController.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return streamController.stream;
  }

  void resetState() {
    searchTextEditingController.clear();
    streamController.sink.add([]);
  }
}
