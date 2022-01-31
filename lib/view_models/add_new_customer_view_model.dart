import 'package:flutter/material.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/dio_network/APis.dart';
import 'package:ims_seller/dio_network/api_client.dart';
import 'package:ims_seller/dio_network/api_response.dart';
import 'package:ims_seller/dio_network/api_route.dart';
import 'package:ims_seller/models/add_new_customer_model.dart';

import '../routes.dart';

class AddNewCustomerViewModel extends ChangeNotifier {
  TextEditingController mobileNumberEditingController = TextEditingController();
  TextEditingController fullNameEditingTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailAddressController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController memberShipNumberEditingController =
      TextEditingController();

  void resetState() {
    mobileNumberEditingController.clear();
    fullNameEditingTextController.clear();
    memberShipNumberEditingController.clear();
    addressController.clear();
    cityController.clear();
  }

  void addNewUser({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "name": fullNameEditingTextController.text,
      "phone": "+959${mobileNumberEditingController.text}",
      "email": emailAddressController.text,
      "city": cityController.text,
      "address": addressController.text,
      "member_ship": memberShipNumberEditingController.text
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.addCustomer,
              body: body,
            ),
            create: () => APIResponse<AddNewCustomerModel>(
                create: () => AddNewCustomerModel()),
            apiFunction: addNewUser)
        .then((response) {
      AppPopUps().dissmissDialog();
      resetState();
      completion();
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
