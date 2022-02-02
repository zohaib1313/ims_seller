import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/model_payment_methods.dart';
import 'package:ims_seller/styles.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class SendAlertInvoiceGeneratedScreen extends StatefulWidget {
  SendAlertInvoiceGeneratedScreen() {}
  static const id = "invoiceGeneratedAlert";

  @override
  State<SendAlertInvoiceGeneratedScreen> createState() =>
      _SendAlertInvoiceGeneratedScreenState();
}

class _SendAlertInvoiceGeneratedScreenState
    extends State<SendAlertInvoiceGeneratedScreen> {
  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);

  @override
  void initState() {
    super.initState();
    view.getNotificationMethods();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(150.r),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  SvgViewer(
                    svgPath: 'assets/icons/icon-check.svg',
                    color: AppColor.greenColor,
                    height: 450.r,
                    width: 450.r,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Invoice Generated",
                    style: AppTextStyles.large
                        .copyWith(color: AppColor.blackColor),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(height: 10.h),
                  Text(
                    "Invoice # S-KBA-9982",
                    style: AppTextStyles.largeBold
                        .copyWith(color: AppColor.blackColor),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    padding: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.blueColor),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer Name:",
                                style: AppTextStyles.smallBold
                                    .copyWith(color: AppColor.whiteColor),
                              ),
                              Text(
                                "HLA San Ei",
                                style: AppTextStyles.largeBold
                                    .copyWith(color: AppColor.whiteColor),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "",
                              style: AppTextStyles.smallBold
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                            Text(
                              "+92123456789",
                              style: AppTextStyles.smallBold
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Text(
                        "Get Bill By",
                        style: AppTextStyles.medium
                            .copyWith(color: AppColor.blackColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: StreamBuilder(
                        stream: view.notificationMethodStream.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ModelMethods>> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            var list = snapshot.data!;
                            List<Widget> listOfWidget = [];

                            for (var element in list) {
                              listOfWidget.add(
                                getNotificationMethod(
                                    view: view,
                                    enabled: element.active ?? true,
                                    title: element.name ?? "-",
                                    icon: getIcon(element.id ?? "sms"),
                                    notificationMethodType:
                                        getType(element.id ?? "sms")),
                              );
                            }
                            return StaggeredGrid.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              children: listOfWidget,
                            );
                          } else {
                            return const Center(
                              child: Text("No data found"),
                            );
                          }
                        }),
                  ),
                  SizedBox(height: 20.h),
                  Button(
                    onTap: () {
                      Navigator.pop(myContext!);
                    },
                    width: 750.w,
                    padding: 10.h,
                    postFixIcon: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.whiteColor,
                      size: 18,
                    ),
                    color: AppColor.greenColor,
                    borderColor: AppColor.greenColor,
                    buttonText: 'Send',
                    textStyle: AppTextStyles.mediumBold
                        .copyWith(color: AppColor.whiteColor),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getSendAlertMethodItem(
      {required String title, required String icon, required bool isSelected}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected ? AppColor.blueColor : AppColor.greyColor)),
      padding: EdgeInsets.all(20.r),
      margin: EdgeInsets.all(50.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor:
                    isSelected ? AppColor.blueColor : AppColor.whiteColor,
                child: const Icon(
                  Icons.check,
                  size: 14,
                  color: AppColor.whiteColor,
                ),
                maxRadius: 10,
              )
            ],
          ),
          SvgViewer(
              svgPath: icon,
              color: isSelected ? AppColor.blueColor : AppColor.blackColor),
          Text(
            title,
            style: AppTextStyles.mediumBold.copyWith(
                color: isSelected ? AppColor.blueColor : AppColor.blackColor),
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}

selectPaymentView(view) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Select Payment",
        style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
      ),
      SizedBox(height: 20.h),
      Center(
        child: StreamBuilder(
            stream: view.notificationMethodStream.stream,
            builder: (BuildContext context,
                AsyncSnapshot<List<ModelMethods>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                var list = snapshot.data!;
                List<Widget> listOfWidget = [];

                for (var element in list) {
                  listOfWidget.add(
                    getNotificationMethod(
                        view: view,
                        enabled: element.active ?? true,
                        title: element.name ?? "-",
                        icon: getIcon(element.id ?? "sms"),
                        notificationMethodType: getType(element.id ?? "sms")),
                  );
                }
                return StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: listOfWidget,
                );
              } else {
                return const Center(
                  child: Text("No data found"),
                );
              }
            }),
      ),
      SizedBox(height: 20.h),
    ],
  );
}

getType(String id) {
  switch (id) {
    case 'sms':
      return NotificationMethods.sms;
    case 'email':
      return NotificationMethods.email;

    case 'print':
      return NotificationMethods.print;
  }
}

getIcon(String id) {
  switch (id) {
    case 'sms':
      return 'assets/icons/icon-sms.svg';
    case 'email':
      return 'assets/icons/icon-mail.svg';
    case 'print':
      return 'assets/icons/icon-printer.svg';
  }
}

getNotificationMethod(
    {required String title,
    required AddNewProductViewModel view,
    required String icon,
    required NotificationMethods notificationMethodType,
    required bool enabled}) {
  return AbsorbPointer(
    absorbing: !enabled,
    child: GestureDetector(
      onTap: () {
        view.updateNotificationMethodTypes(notificationMethodType);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: enabled ? AppColor.whiteColor : AppColor.alphaGrey,
            border: Border.all(
                color: !enabled
                    ? AppColor.alphaGrey
                    : (view.selectedNotificationMethods
                            .contains(notificationMethodType)
                        ? AppColor.blueColor
                        : AppColor.greyColor))),
        padding: EdgeInsets.all(20.r),
        margin: EdgeInsets.all(50.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: !enabled
                      ? AppColor.alphaGrey
                      : (view.selectedNotificationMethods
                              .contains(notificationMethodType)
                          ? AppColor.blueColor
                          : AppColor.whiteColor),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: AppColor.whiteColor,
                  ),
                  maxRadius: 10,
                )
              ],
            ),
            SvgViewer(
                svgPath: icon,
                color: view.selectedNotificationMethods
                        .contains(notificationMethodType)
                    ? AppColor.blueColor
                    : AppColor.blackColor),
            Text(
              title,
              style: AppTextStyles.mediumBold.copyWith(
                  color: view.selectedNotificationMethods
                          .contains(notificationMethodType)
                      ? AppColor.blueColor
                      : AppColor.blackColor),
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    ),
  );
}
