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

  Stream<List<ModelInvoiceMerchant>> getMerchantInvoiceList() {
    Map<String, dynamic> body = {};
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
        // searchListStreamController.sink.add(response.response!.data!);
        //notifyListener3s();
        streamController.sink.add(response.response!.data!.invoicesList);
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
}
