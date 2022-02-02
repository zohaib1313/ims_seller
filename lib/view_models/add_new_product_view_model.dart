import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/dio_network/APis.dart';
import 'package:ims_seller/dio_network/api_client.dart';
import 'package:ims_seller/dio_network/api_response.dart';
import 'package:ims_seller/dio_network/api_route.dart';
import 'package:ims_seller/dio_network/error_mapper.dart';
import 'package:ims_seller/models/add_new_customer_model.dart';
import 'package:ims_seller/models/model_payment_methods.dart';
import 'package:ims_seller/models/product_detail_scanned_model.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/utils/utils.dart';

import '../routes.dart';

class AddNewProductViewModel extends ChangeNotifier {
  Views _currentView = Views.scanProduct;
  CustomerModel? _modelUser;

  PaymentMethod selectedPaymentMethod = PaymentMethod.cash;
  var selectedNotificationMethods = <NotificationMethods>{
    NotificationMethods.sms
  };

  TextEditingController discountedPriceController =
      TextEditingController(text: '0.0');
  String _nextTitle = "next";

  String get nextTitle => _nextTitle;

  set nextTitle(String value) {
    _nextTitle = value;
    notifyListeners();
  }

  void changePaymentMethod(PaymentMethod selectedPaymentMethod) {
    this.selectedPaymentMethod = selectedPaymentMethod;
    notifyListeners();
  }

  List<ProductDetailScannedModel?> listOfScannedProducts = [];

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
    print("going forward to ${view.name}");
    _viewsHistory.add(view);
    currentView = view;
  }

  Future<bool> goBackwards() {
    print(_viewsHistory.last);
    if (_viewsHistory.last == Views.scanProduct) {
      print(_viewsHistory);
      resetState();
      return Future.value(true);
    } else {
      if (_currentView == Views.listProducts) {
        listOfScannedProducts.clear();
        calculateTotalAmount();
      }
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
      // barcodeScanRes = '888462108416';

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
    listOfScannedProducts = [];
    _totalAmount = 0.0;
    selectedNotificationMethods = <NotificationMethods>{
      NotificationMethods.sms
    };
    discountedPriceController.clear();
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
              APIType.getProductDetails,
              body: body,
            ),
            create: () => APIResponse<ProductDetailScannedModel>(
                create: () => ProductDetailScannedModel()),
            apiFunction: getProductDetails)
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response!.data != null) {
        print("data not null");
        listOfScannedProducts.add(response.response!.data);
        calculateTotalAmount();
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

///////////////////total amount calculatin///////////////////
  double _totalAmount = 0.0;

  double get totalAmount => _totalAmount;

  set totalAmount(double value) {
    _totalAmount = value;
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    _totalAmount = 0.0;
    if (listOfScannedProducts.isNotEmpty) {
      for (var element in listOfScannedProducts) {
        int qty = element?.localQty ?? 0;
        double price =
            (double.parse(element?.productDetail?.salePrice ?? "0.0"));
        double fullPrice = (price * qty);
        _totalAmount = _totalAmount + fullPrice;

        // double disPrice = 0.0;
        // if (discountedPriceController.text.isNotEmpty) {
        //   disPrice = double.parse(discountedPriceController.text);
        // }
        //_totalAmount = _totalAmount - disPrice;
      }
    }
    refresh();
  }

  StreamController<List<ModelMethods>> paymentListStream =
      StreamController.broadcast();
  StreamController<List<ModelMethods>> notificationMethodStream =
      StreamController.broadcast();

  Stream<List<ModelMethods>> getPaymentMethods() {
    Map<String, dynamic> body = {};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.getPaymentMethods,
              body: body,
            ),
            create: () =>
                APIResponse<ModelMethodsList>(create: () => ModelMethodsList()),
            apiFunction: getPaymentMethods)
        .then((response) {
      if (response.response!.data != null) {
        paymentListStream.sink.add(response.response!.data!.modelMethodList);
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      paymentListStream.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return paymentListStream.stream;
  }

  Stream<List<ModelMethods>> getNotificationMethods() {
    Map<String, dynamic> body = {};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.getNotificationMethods,
              body: body,
            ),
            create: () =>
                APIResponse<ModelMethodsList>(create: () => ModelMethodsList()),
            apiFunction: getPaymentMethods)
        .then((response) {
      if (response.response!.data != null) {
        notificationMethodStream.sink
            .add(response.response!.data!.modelMethodList);
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      notificationMethodStream.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return notificationMethodStream.stream;
  }

  CustomerModel? get modelUser => _modelUser;

  set modelUser(CustomerModel? value) {
    _modelUser = value;
    // notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void updateNotificationMethodTypes(
      NotificationMethods notificationMethodType) {
    if (selectedNotificationMethods.contains(notificationMethodType)) {
      selectedNotificationMethods.remove(notificationMethodType);
    } else {
      selectedNotificationMethods.add(notificationMethodType);
    }
    notifyListeners();
  }
}

enum Views {
  scanProduct,
  listProducts,
  selectPayment,
  bankPaymentDetails,
}

enum PaymentMethod { bank, cash, creditCard }
enum NotificationMethods { sms, email, print }
