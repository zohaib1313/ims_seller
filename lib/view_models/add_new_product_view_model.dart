import 'dart:async';
import 'dart:convert';

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
import 'package:ims_seller/models/bank_account_model.dart';
import 'package:ims_seller/models/header_invoice_product_model.dart';
import 'package:ims_seller/models/invoice_created_model.dart';
import 'package:ims_seller/models/model_payment_methods.dart';
import 'package:ims_seller/models/product_detail_scanned_model.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:intl/intl.dart';

import '../routes.dart';

class AddNewProductViewModel extends ChangeNotifier {
  Views _currentView = Views.scanProduct;
  CustomerModel? _modelUser;

  PaymentMethod selectedPaymentMethod = PaymentMethod.cs;

  TextEditingController discountedPriceController =
      TextEditingController(text: '0.0');
  String _nextTitle = "next";

  String get nextTitle => _nextTitle;

  BankAccountModel? _selectedBank;

  BankAccountModel? get selectedBank => _selectedBank;
  String? _dateTimeOfInvoice;
  set selectedBank(BankAccountModel? value) {
    _selectedBank = value;
    notifyListeners();
  }

  TextEditingController selectedBankTransactionIdController =
      TextEditingController();

  String? get dateTimeOfInvoice => _dateTimeOfInvoice;

  set dateTimeOfInvoice(String? value) {
    _dateTimeOfInvoice = value;
  }

  set nextTitle(String value) {
    _nextTitle = value;
    notifyListeners();
  }

  void changePaymentMethod(PaymentMethod selectedPaymentMethod) {
    if (selectedPaymentMethod == PaymentMethod.cc ||
        selectedPaymentMethod == PaymentMethod.cs) {
      selectedBank = null;
    }
    this.selectedPaymentMethod = selectedPaymentMethod;
    notifyListeners();
  }

  List<ProductDetailScannedModel?> listOfScannedProducts = [];

  removeProductListItemAt(int index) {
    if (listOfScannedProducts.isNotEmpty) {
      listOfScannedProducts.removeAt(index);
      calculateTotalAmount();
    }
  }

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

      if (_currentView == Views.bankPaymentDetails) {
        selectedBank = null;
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
      //barcodeScanRes = '888462108416';

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
    selectedPaymentMethod = PaymentMethod.cs;
    _totalAmount = 0.0;
    selectedBankTransactionIdController.clear();
    selectedBank = null;

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
      if (response.response?.data != null) {
        print("data not null");

        ProductDetailScannedModel model = response.response!.data!;
        if (model.productDetail!.haveDiffBarcode!) {
          bool isAlreadyPresent = false;
          for (int i = 0; i < listOfScannedProducts.length; i++) {
            if (listOfScannedProducts[i]!.imeiNumber == model.imeiNumber) {
              if ((listOfScannedProducts[i]!.localQty <
                  listOfScannedProducts[i]!
                      .productDetail!
                      .availableProductQuantityInBranch!)) {
                listOfScannedProducts[i]!.localQty =
                    listOfScannedProducts[i]!.localQty + 1;
              } else {
                AppPopUps.showAlertDialog(message: "Out of stock");
              }
              isAlreadyPresent = true;
            }
          }
          if (!isAlreadyPresent) {
            listOfScannedProducts.add(model);
          } else {
            AppPopUps.showAlertDialog(message: "Product Already Present");
          }
        } else {
          bool isAlreadyPresent = false;

          for (int i = 0; i < listOfScannedProducts.length; i++) {
            if (listOfScannedProducts[i]!.imeiNumber == model.imeiNumber) {
              isAlreadyPresent = true;
              if ((listOfScannedProducts[i]!.localQty <
                  listOfScannedProducts[i]!
                      .productDetail!
                      .availableProductQuantityInBranch!)) {
                listOfScannedProducts[i]!.localQty =
                    listOfScannedProducts[i]!.localQty + 1;
              } else {
                AppPopUps.showAlertDialog(message: "Out of stock");
              }
            }
          }
          if (!isAlreadyPresent) {
            listOfScannedProducts.add(model);
          }
        }

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

  StreamController<List<BankAccountModel>> bankAccountListStream =
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

  Stream<List<BankAccountModel>> getBankAccountList() {
    Map<String, dynamic> body = {};
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.getBankAccountsList,
              body: body,
            ),
            create: () => APIResponse<BankAccountModelList>(
                create: () => BankAccountModelList()),
            apiFunction: getBankAccountList)
        .then((response) {
      if (response.response!.data != null) {
        bankAccountListStream.sink
            .add(response.response!.data!.bankAccountModelList);
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      bankAccountListStream.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return bankAccountListStream.stream;
  }

  CustomerModel? get modelUser => _modelUser;

  set modelUser(CustomerModel? value) {
    _modelUser = value;
    // notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  InvoiceCreatedModel? _invoiceCreatedModel;

  InvoiceCreatedModel? get invoiceCreatedModel => _invoiceCreatedModel;

  set invoiceCreatedModel(InvoiceCreatedModel? value) {
    _invoiceCreatedModel = value;
    notifyListeners();
  }

  createInvoice({completion}) async {
    dateTimeOfInvoice =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
    AppPopUps().showProgressDialog(context: myContext);

    Map<String, dynamic> headersMultiPart = {
      'Authorization': 'Token 614e83765257d5c98edf7bbb72958a4fd13e4519',
    };
    List<Map<String, String>> listOfProducts = [];
    printWrapped("sizeee===" + listOfScannedProducts.length.toString());
    for (var value in listOfScannedProducts) {
      listOfProducts.add(HeaderInvoiceModelProduct(
              imei_number: value?.imeiNumber ?? "",
              product_price: value?.productDetail?.salePrice ?? "",
              product_qty: value!.localQty.toString())
          .toJson());
    }
    var formData = FormData.fromMap({
      "data": json.encode({
        "reference": selectedBankTransactionIdController.text.isEmpty
            ? ""
            : selectedBankTransactionIdController.text,
        "total_discount": double.parse(discountedPriceController.text.isEmpty
            ? "0.0"
            : discountedPriceController.text),
        "payment_method": selectedPaymentMethod.name,
        "bank_account_id": selectedBank?.id ?? "",

        ///2022-01-10 15:20:46
        "invoice_date": dateTimeOfInvoice ?? "-",
        "to_client": modelUser!.id.toString(),
        "sale_desc": "",
        "internal_desc": "",
        "amount": (totalAmount -
                double.parse((discountedPriceController.text.isEmpty
                    ? "0.0"
                    : discountedPriceController.text)))
            .toString(),
        "invoice_amount": totalAmount.toString(),
        "seller_id": UserDefaults.getUserSession()!.userId.toString(),
        "product_list": listOfProducts
      })
    });
    printWrapped("form data");
    var client = APIClient(
        isCache: false,
        baseUrl: ApiConstants.baseUrl,
        contentType: "multipart/form-data");
    client
        .request(
            route: APIRoute(APIType.createInvoice,
                body: formData, headers: headersMultiPart),
            create: () => APIResponse<InvoiceCreatedModel>(
                create: () => InvoiceCreatedModel()),
            apiFunction: createInvoice)
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response?.data != null) {
        _invoiceCreatedModel = response.response?.data;
        completion();
      }
    }).catchError((error) {
      print("error=  ${error.toString()}");
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
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

enum PaymentMethod { bt, cs, cc }
