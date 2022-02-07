import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/mode_printer_product.dart';
import 'package:ims_seller/models/model_payment_methods.dart';
import 'package:ims_seller/screens/success_screen.dart';
import 'package:ims_seller/styles.dart';
import 'package:ims_seller/utils/printing.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/view_models/send_alert_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class SendAlertInvoiceGeneratedScreen extends StatefulWidget {
  static const id = "invoiceGeneratedAlert";
  int? invoiceId;
  String? invoiceNumber;
  String? userName;
  String? address;
  String? phoneNo;
  String? paymentMethod;
  bool? haveMail;
  String? totalAmount;
  String? discount;
  List<ModelPrinterProduct> listOfProducts;

  SendAlertInvoiceGeneratedScreen(
      {Key? key,
      this.invoiceId,
      this.invoiceNumber,
      this.userName,
      this.address,
      this.phoneNo,
      this.paymentMethod,
      this.haveMail,
      this.totalAmount,
      this.discount,
      required this.listOfProducts})
      : super(key: key);

  @override
  State<SendAlertInvoiceGeneratedScreen> createState() =>
      _SendAlertInvoiceGeneratedScreenState();
}

class _SendAlertInvoiceGeneratedScreenState
    extends State<SendAlertInvoiceGeneratedScreen> {
  var view = Provider.of<SendAlertViewModel>(myContext!, listen: true);

  @override
  void initState() {
    super.initState();
    view.getNotificationMethods(haveMail: widget.haveMail ?? false);
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
                    "Invoice # ${widget.invoiceNumber ?? "--"}",
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
                        Expanded(
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
                                widget.userName ?? "-",
                                style: AppTextStyles.small
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
                              widget.phoneNo ?? "-",
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
                            return GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var element = list[index];

                                  return getNotificationMethod(
                                      enabled: element.active ?? true,
                                      title: element.name ?? "-",
                                      icon: getIcon(element.id ?? "sms"),
                                      notificationMethodType:
                                          getType(element.id ?? "sms"));
                                });
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
                      if (view.selectedNotificationMethods.isEmpty) {
                        AppPopUps.showAlertDialog(
                          message: "Select any option first",
                        );
                      } else if ((view.selectedNotificationMethods
                              .contains(NotificationMethods.sms)) ||
                          (view.selectedNotificationMethods
                              .contains(NotificationMethods.email))) {
                        view.sendNotifications(
                            completion: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SuccessScreen(
                                        title: "Notification sent successfully",
                                        printt: (view
                                            .selectedNotificationMethods
                                            .contains(
                                                NotificationMethods.print)),
                                      )));
                              // view.resetState();
                              // Navigator.pop(myContext!);
                            },
                            invoiceId: widget.invoiceId ?? 0);
                      } else {
                        MyPrinting().doPrint(
                            title: "  mDrive(Kabar Aye) ",
                            address: widget.address ?? "",
                            stringPhoneNo: widget.phoneNo ?? "",
                            invoiceNumber: widget.invoiceNumber ?? "",
                            dateTime: (DateFormat("yyyy-MM-dd hh:ss a")
                                    .format(DateTime.now()))
                                .toString(),
                            salePersonName: widget.userName ?? "-",
                            customer:
                                UserDefaults.getUserSession()?.username ?? "",
                            paymentMethod: widget.paymentMethod ?? "",
                            totalAmount: widget.totalAmount ?? "0.0",
                            discount: widget.discount ?? "0.0",
                            listOfProducts: widget.listOfProducts,
                            numberOfItems:
                                widget.listOfProducts.length.toString());
                      }
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
                return GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      var element = list[index];
                      return getNotificationMethod(
                          enabled: element.active ?? true,
                          title: element.name ?? "-",
                          icon: getIcon(element.id ?? "sms"),
                          notificationMethodType: getType(element.id ?? "sms"));
                    });
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
    required String icon,
    required NotificationMethods notificationMethodType,
    required bool enabled}) {
  return AbsorbPointer(
    absorbing: !enabled,
    child: GestureDetector(
      onTap: () {
        Provider.of<SendAlertViewModel>(myContext!, listen: false)
            .updateNotificationMethodTypes(notificationMethodType);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: enabled ? AppColor.whiteColor : AppColor.alphaGrey,
            border: Border.all(
                color: !enabled
                    ? AppColor.alphaGrey
                    : (Provider.of<SendAlertViewModel>(myContext!,
                                listen: false)
                            .selectedNotificationMethods
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
                      : (Provider.of<SendAlertViewModel>(myContext!,
                                  listen: false)
                              .selectedNotificationMethods
                              .contains(notificationMethodType)
                          ? AppColor.blueColor
                          : AppColor.whiteColor),
                  child: enabled
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: AppColor.whiteColor,
                        )
                      : const IgnorePointer(),
                  maxRadius: 10,
                )
              ],
            ),
            SvgViewer(
                svgPath: icon,
                color:
                    Provider.of<SendAlertViewModel>(myContext!, listen: false)
                            .selectedNotificationMethods
                            .contains(notificationMethodType)
                        ? AppColor.blueColor
                        : AppColor.blackColor),
            Text(
              title,
              style: AppTextStyles.mediumBold.copyWith(
                  color:
                      Provider.of<SendAlertViewModel>(myContext!, listen: false)
                              .selectedNotificationMethods
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
