import 'package:flutter/material.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/dio_network/APis.dart';
import 'package:ims_seller/dio_network/api_client.dart';
import 'package:ims_seller/dio_network/api_route.dart';
import 'package:ims_seller/models/signin_model.dart';
import 'package:ims_seller/utils/user_defaults.dart';

import '../routes.dart';

class SignInViewModel extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  singInUser({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "username": userNameController.text,
      "password": userPasswordController.text,
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.login,
              body: body,
            ),
            create: () => SignInModel(),
            apiFunction: singInUser)
        .then((response) {
      AppPopUps().dissmissDialog();

      UserDefaults.saveUserSession(response.response!);
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
      return Future.value(null);
    });
  }

  resetState() {
    userNameController.clear();
    userPasswordController.clear();
  }
}
