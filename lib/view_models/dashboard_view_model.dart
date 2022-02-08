import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/dio_network/APis.dart';
import 'package:ims_seller/dio_network/api_client.dart';
import 'package:ims_seller/dio_network/api_response.dart';
import 'package:ims_seller/dio_network/api_route.dart';
import 'package:ims_seller/dio_network/error_mapper.dart';
import 'package:ims_seller/models/ModelSalesTarget.dart';
import 'package:ims_seller/models/invoice_sale_model.dart';
import 'package:ims_seller/models/model_invoice_merchat.dart';
import 'package:ims_seller/utils/utils.dart';

import '../routes.dart';

class DashboardViewModel extends ChangeNotifier {
  StreamController<List<ModelInvoiceMerchant>> streamController =
      StreamController.broadcast();

  int startPoint = 0;
  int endPoint = 10;
  bool inProgress = false;

  Stream<List<ModelInvoiceMerchant>> getMerchantInvoiceList({end, start}) {
    Map<String, dynamic> body = {"start": start, "end": end};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.searchMerchantInvoices,
              body: body,
            ),
            create: () => APIResponse<InvoicesMerchantModelList>(
                create: () => InvoicesMerchantModelList()),
            apiFunction: getMerchantInvoiceList)
        .then((response) {
      if (response.response!.data != null) {
        streamController.sink.add(response.response!.data!.invoicesList);

        // notifyListeners();
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      streamController.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return streamController.stream;
  }

  void getSaleInvoice({required String invoiceId, completion}) {
    AppPopUps().showProgressDialog(context: myContext!);

    Map<String, dynamic> body = {"invoice_id": invoiceId};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.getInvoiceDetails,
              body: body,
            ),
            create: () =>
                APIResponse<InvoiceSaleModel>(create: () => InvoiceSaleModel()),
            apiFunction: getSaleInvoice)
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response!.data != null) {
        completion(response.response!.data);
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: "Error",
          error: error.toString(),
          onButtonPressed: () {
            AppPopUps().dissmissDialog();
          });
    });
  }

  StreamController<ModelSalesTarget> salesTargetInvoice =
      StreamController.broadcast();

  Stream<ModelSalesTarget> getInvoiceTargets() {
    Map<String, dynamic> body = {};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.getSalesTarget,
              body: body,
            ),
            create: () =>
                APIResponse<ModelSalesTarget>(create: () => ModelSalesTarget()),
            apiFunction: getInvoiceTargets)
        .then((response) {
      if (response.response!.data != null) {
        salesTargetInvoice.sink.add(response.response!.data!);
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      salesTargetInvoice.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return salesTargetInvoice.stream;
  }

  resetState() {
    streamController.sink.add([]);
    streamController2.sink.add(false);
    listOfInvoices.clear();
    startPoint = 0;
    endPoint = 10;
    haveMoreItem = true;
  }

  bool haveMoreItem = true;
  StreamController<bool> streamController2 = StreamController.broadcast();
  List<ModelInvoiceMerchant> listOfInvoices = [];

  Stream<bool> getMerchantPaginatedInvoice() {
    streamController2.sink.add(true);
    Map<String, dynamic> body = {"start": startPoint, "end": endPoint};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.searchMerchantInvoices,
              body: body,
            ),
            create: () => APIResponse<InvoicesMerchantModelList>(
                create: () => InvoicesMerchantModelList()),
            apiFunction: getMerchantInvoiceList)
        .then((response) {
      if (response.response!.data != null) {
        if (response.response!.data!.invoicesList.isNotEmpty) {
          listOfInvoices.addAll(response.response!.data!.invoicesList);
          streamController2.sink.add(false);
          startPoint = endPoint;
          endPoint = endPoint + 10;
          inProgress = false;
        } else {
          haveMoreItem = false;
        }
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      streamController2.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return streamController2.stream;
  }
}
