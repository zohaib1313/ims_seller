import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/dio_network/APis.dart';
import 'package:ims_seller/dio_network/api_client.dart';
import 'package:ims_seller/dio_network/api_response.dart';
import 'package:ims_seller/dio_network/api_route.dart';
import 'package:ims_seller/dio_network/error_mapper.dart';
import 'package:ims_seller/models/model_payment_methods.dart';
import 'package:ims_seller/utils/utils.dart';

import '../routes.dart';

class SendAlertViewModel extends ChangeNotifier {
  StreamController<List<ModelMethods>> notificationMethodStream =
      StreamController.broadcast();

  Stream<List<ModelMethods>> getNotificationMethods({required bool haveMail}) {
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
            apiFunction: getNotificationMethods)
        .then((response) {
      if (response.response!.data != null) {
        List<ModelMethods> list = response.response!.data!.modelMethodList;
        List<ModelMethods> finalList = [];
        for (var element in list) {
          if (element.id == 'email') {
            if (haveMail) {
              finalList.add(element);
            }
          } else {
            finalList.add(element);
          }
        }
        notificationMethodStream.sink.add(finalList);
      }
    }).catchError((error) {
      printWrapped("error= " + error.toString());
      notificationMethodStream.addError(
          error is DioError ? ErrorMapper.dioError(error) : error.toString());
    });
    return notificationMethodStream.stream;
  }

  var selectedNotificationMethods = <NotificationMethods>{};

  void updateNotificationMethodTypes(
      NotificationMethods notificationMethodType) {
    if (selectedNotificationMethods.contains(notificationMethodType)) {
      selectedNotificationMethods.remove(notificationMethodType);
    } else {
      selectedNotificationMethods.add(notificationMethodType);
    }
    notifyListeners();
  }

  void sendNotifications({completion, required int invoiceId}) {
    AppPopUps().showProgressDialog(context: myContext!);
    String sms = "0";
    String email = "0";
    if (selectedNotificationMethods.contains(NotificationMethods.sms)) {
      sms = "1";
    }
    if (selectedNotificationMethods.contains(NotificationMethods.email)) {
      email = "1";
    }

    Map<String, dynamic> body = {
      "invoice_id": invoiceId,
      "email": sms,
      "sms": email
    };
    var client = APIClient(isCache: false);
    client
        .request(
            route: APIRoute(
              APIType.sendNotifications,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: sendNotifications)
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response?.status != null) {
        printWrapped("sent ${response.response?.status}");
        if (response.response?.status == true) {
          completion();
        } else {
          AppPopUps().showErrorPopUp(
              title: "Error",
              error: response.response?.responseMessage ?? "--",
              onButtonPressed: () {
                AppPopUps().dissmissDialog();
              });
        }
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

  resetState() {
    selectedNotificationMethods = <NotificationMethods>{};
  }
}

enum NotificationMethods { sms, email, print }
