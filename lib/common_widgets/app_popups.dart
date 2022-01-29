import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ims_seller/styles.dart';

import '../routes.dart';

class AppPopUps {
  bool isDialogShowing = true;

  void oneButtonPop(
      {String? iconPath,
      String? title,
      String? subTitle,
      String? buttonText,
      TextStyle? style,
      bool? isBackPressDissmiss,
      Color? buttonColor,
      Function? onButtonPress}) {
    isDialogShowing = true;
    showDialog(
            context: navigatorKey.currentState!.context,
            useRootNavigator: false,
            barrierColor: Colors.transparent.withOpacity(0),
            useSafeArea: false,
            builder: (context) => WillPopScope(
                child: dialogContent(
                    iconPath: iconPath,
                    title: title,
                    subTitle: subTitle,
                    leftButtonText: buttonText,
                    style: style,
                    leftButtonPress: onButtonPress),
                onWillPop: () {
                  return isBackPressDissmiss == null
                      ? Future.value(true)
                      : Future.value(isBackPressDissmiss);
                }),
            barrierDismissible: false)
        .then((value) {
      isDialogShowing = false;
    });
  }

  void twoButtonPop({
    BuildContext? context,
    String? iconPath,
    String? title,
    String? subTitle,
    String? leftButtonText,
    String? rightButtonText,
    Color? leftButtonColor,
    Color? rightButtonColor,
    Function? leftButtonPress,
    Function? rightButtonPress,
    Color? rightButtonTextColor,
    Color? leftButtonButtonTextColor,
    bool? barrierDismissible,
    TextStyle? style,
  }) {
    isDialogShowing = true;
    showDialog(
            context: context ?? navigatorKey.currentState!.context,
            useRootNavigator: false,
            barrierColor: Colors.transparent.withOpacity(0),
            useSafeArea: false,
            builder: (context) => dialogContent(
                iconPath: iconPath,
                title: title,
                subTitle: subTitle,
                leftButtonText: leftButtonText,
                rightButtonText: rightButtonText,
                leftButtonColor: leftButtonColor,
                rightButtonColor: rightButtonColor,
                style: style,
                leftButtonPress: leftButtonPress,
                rightButtonPress: rightButtonPress,
                leftButtonButtonTextColor: leftButtonButtonTextColor,
                rightButtonTextColor: rightButtonTextColor),
            barrierDismissible: barrierDismissible ?? false)
        .then((value) {
      isDialogShowing = false;
    });
  }

  dialogContent({
    BuildContext? context,
    String? iconPath,
    String? title,
    String? subTitle,
    String? leftButtonText,
    String? rightButtonText,
    Color? leftButtonColor,
    Color? rightButtonColor,
    Function? leftButtonPress,
    Function? rightButtonPress,
    Color? rightButtonTextColor,
    Color? leftButtonButtonTextColor,
    TextStyle? style,
  }) {
    return Container(
      color: AppColor.blackColor.withOpacity(0.5),
      width: double.infinity,
      child: Dialog(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(25.r)),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(300.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      iconPath!,
                      color: AppColor.blueColor,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      subTitle!,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () => leftButtonPress!(),
                        child: Container(
                          color: leftButtonColor ?? AppColor.blueColor,
                          child: Padding(
                            padding: EdgeInsets.all(50.w),
                            child: Center(
                              child: Text(
                                leftButtonText!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    rightButtonText == null
                        ? Container()
                        : Expanded(
                            child: InkWell(
                              onTap: () => rightButtonPress!(),
                              child: Container(
                                color: rightButtonColor ?? AppColor.blackColor,
                                child: Padding(
                                  padding: EdgeInsets.all(50.w),
                                  child: Center(
                                    child: Text(
                                      (rightButtonText.isEmpty)
                                          ? ''
                                          : rightButtonText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showProgressDialog({BuildContext? context, bool? barrierDismissal}) {
    isDialogShowing = true;
    showDialog(
        useRootNavigator: false,
        useSafeArea: false,
        barrierDismissible: barrierDismissal ?? false,
        context: context!,
        builder: (context) => Center(
              child: Container(
                decoration: BoxDecoration(
                  //color: AppColors(..blackcardsBackground,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(25.r)),
                  boxShadow: [
                    BoxShadow(
                      //  color: AppColors().shadowColor,
                      color: Colors.transparent,
                      spreadRadius: 5.r,
                      blurRadius: 5.r,
                      offset: const Offset(3, 5), // changes position of shadow
                    ),
                  ],
                ),
                height: 120.h,
                width: 120.h,
                //  child: Lottie.asset(AssetsNames().loader),
                child: const CircularProgressIndicator(),
              ),
            )).then((value) {
      isDialogShowing = false;
    });
  }

  showErrorPopUp(
      {String? title,
      String? error,
      onButtonPressed,
      ErrorType errorType = ErrorType.ERROR}) {
    oneButtonPop(
        title: errorType == ErrorType.ERROR ? title : 'Warning',
        subTitle: error,
        iconPath: 'assets/icons/icon-offer.svg',
        buttonText: 'Ok',
        buttonColor: AppColor.greenColor,
        onButtonPress: onButtonPressed);
  }

  dissmissDialog() {
    if (isDialogShowing) {
      navigatorKey.currentState!.pop();
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(myContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: AppColor.redColor,
      ),
    );
  }
}

enum ErrorType { ERROR, WARNING }
