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

  Future<bool> resetState() {
    mobileNumberEditingController.clear();
    fullNameEditingTextController.clear();
    emailAddressController.clear();
    addressController.clear();
    cityController.clear();
    return Future.value(true);
  }

  void addNewUser({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "name": fullNameEditingTextController.text.isEmpty
          ? ""
          : fullNameEditingTextController.text,
      "phone": "+959${mobileNumberEditingController.text}",
      "email": emailAddressController.text.isEmpty
          ? ""
          : emailAddressController.text,
      "city": cityController.text.isEmpty ? "" : cityController.text,
      "address": addressController.text.isEmpty ? "" : addressController.text,
      /*  "member_ship": memberShipNumberEditingController.text.isEmpty
          ? ""
          : memberShipNumberEditingController.text*/
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.addCustomer,
              body: body,
            ),
            create: () =>
                APIResponse<CustomerModel>(create: () => CustomerModel()),
            apiFunction: addNewUser)
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response?.data != null) {
        resetState();
        completion(response.response!.data!);
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
