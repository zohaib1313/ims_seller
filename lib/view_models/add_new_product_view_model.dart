import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddNewProductViewModel extends ChangeNotifier {
  Views _currentView = Views.scanProduct;

  PaymentMethod selectedPaymentMethod = PaymentMethod.bank;

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

  scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    print(barcodeScanRes);
    notifyListeners();
  }

  void resetState() {
    _viewsHistory = [Views.scanProduct];
    currentView = Views.scanProduct;
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
}

enum Views {
  scanProduct,
  listProducts,
  selectPayment,
  bankPaymentDetails,
}

enum PaymentMethod { bank, cash, creditCard }
