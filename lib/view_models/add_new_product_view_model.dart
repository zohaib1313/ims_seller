import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/dio_network/APis.dart';
import 'package:ims_seller/dio_network/api_client.dart';
import 'package:ims_seller/dio_network/api_response.dart';
import 'package:ims_seller/dio_network/api_route.dart';
import 'package:ims_seller/models/product_detail_scanned_model.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/utils/utils.dart';

import '../routes.dart';

class AddNewProductViewModel extends ChangeNotifier {
  Views _currentView = Views.scanProduct;

  PaymentMethod selectedPaymentMethod = PaymentMethod.bank;
  ProductDetailScannedModel? productDetailScannedModel;

  Views get currentView => _currentView;
  List<Views> _viewsHistory = [Views.scanProduct];

  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  List<Views> get viewsHistory => _viewsHistory;

  set viewsHistory(List<Views> value) {
    _viewsHistory = value;
  }

  void goForwards(Views view) {
    _viewsHistory.add(view);
    currentView = view;
    notifyListeners();
  }

  Future<bool> goBackwards() {
    print(_viewsHistory.last);
    if (_viewsHistory.last == Views.scanProduct) {
      print(_viewsHistory);
      resetState();
      return Future.value(true);
    } else {
      _viewsHistory.removeLast();
      _currentView = _viewsHistory.last;
      notifyListeners();
      return Future.value(false);
    }
  }

  set currentView(Views value) {
    _currentView = value;
    notifyListeners();
  }

  scanBarcodeNormal({completion}) async {
    String barcodeScanRes = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      barcodeScanRes = '888462108416';

      ///temporary todo
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    completion(barcodeScanRes);
    print(barcodeScanRes);
  }

  void resetState() {
    _viewsHistory = [Views.scanProduct];
    currentView = Views.scanProduct;
    productDetailScannedModel = null;
    notifyListeners();
  }

  String getHeaderText() {
    switch (currentView) {
      case Views.scanProduct:
        return "Sale Invoice";
      case Views.listProducts:
        return "Sale Invoice";
      case Views.selectPayment:
        return "Payment Method";
      case Views.bankPaymentDetails:
        return "Bank Transfer";
    }
  }

  void getProductDetails({required String code, completion}) {
    AppPopUps().showProgressDialog(context: myContext!);

    Map<String, dynamic> body = {
      "date_time": DateTime.now().toString(),
      "imei_number": code,
      "for_type": "sale",
      "branch_id": UserDefaults.getUserSession()?.branchDetail?.id ?? ""
    };
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.getInvoiceDetails,
              body: body,
            ),
            create: () => APIResponse<ProductDetailScannedModel>(
                create: () => ProductDetailScannedModel()),
            apiFunction: getProductDetails)
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response!.data != null) {
        productDetailScannedModel = response.response!.data;
        completion();
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
}

enum Views {
  scanProduct,
  listProducts,
  selectPayment,
  bankPaymentDetails,
}

enum PaymentMethod { bank, cash, creditCard }
