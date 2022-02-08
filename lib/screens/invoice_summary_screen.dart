import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/mode_printer_product.dart';
import 'package:ims_seller/screens/send_alert_screen.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../styles.dart';
import 'add_new_products/add_new_product_views.dart';

class InvoiceSummaryScreen extends StatelessWidget {
  InvoiceSummaryScreen({Key? key}) : super(key: key);
  static const id = 'InvoiceSummaryScreen';
  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(top: 120.r, left: 120.r, right: 120.r),
          child: Column(
            children: [
              getHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Customer Name:",
                                    style: AppTextStyles.small
                                        .copyWith(color: AppColor.whiteColor),
                                  ),
                                  Text(
                                    view.modelUser?.name ?? '',
                                    style: AppTextStyles.smallBold
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
                                  '',
                                  style: AppTextStyles.smallBold
                                      .copyWith(color: AppColor.whiteColor),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  view.modelUser?.phone ?? '',
                                  style: AppTextStyles.smallBold
                                      .copyWith(color: AppColor.whiteColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      bottomView()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            Navigator.of(myContext!).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: SvgViewer(
              svgPath: 'assets/icons/icon-arrow-back.svg',
              height: 25,
              width: 25,
              color: AppColor.blackColor,
            ),
          ),
        ),
        SizedBox(width: 100.w),
        Text(
          "Invoice Summary",
          style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
        )
      ],
    );
  }

  bottomView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              productListView(view, false),
              SizedBox(height: 20.h),
              const Divider(color: AppColor.blackColor),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Payment Method:',
                        style: AppTextStyles.mediumBold
                            .copyWith(color: AppColor.blackColor),
                      )),
                  Spacer(),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: SvgViewer(
                              svgPath: getPaymentMethodIcon(),
                              width: 20,
                              height: 20,
                            ),
                          ),
                          SizedBox(width: 50.w),
                          Flexible(
                            child: Text(
                              getPaymentMethodName(),
                              style: AppTextStyles.mediumBold
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(height: 20.h),
              const Divider(color: AppColor.blackColor),
              Visibility(
                visible:
                    view.selectedPaymentMethod.name == PaymentMethod.bt.name,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(
                              'Transaction id',
                              style: AppTextStyles.medium
                                  .copyWith(color: AppColor.blackColor),
                            )),
                        Spacer(),
                        Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    view.selectedBankTransactionIdController
                                        .text
                                        .toString(),
                                    style: AppTextStyles.medium
                                        .copyWith(color: AppColor.blackColor),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const Divider(color: AppColor.blackColor),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              (UserDefaults.getUserSession()?.discountPermission ?? false)
                  ? showDiscount()
                  : const IgnorePointer(),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Total Amount',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColor.blackColor),
                      )),
                  Spacer(),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              formatAmount(view.totalAmount.toString()),
                              style: AppTextStyles.medium
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(height: 20.h),
              const Divider(color: AppColor.blackColor),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Discount',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColor.blackColor),
                      )),
                  Spacer(),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              formatAmount(
                                  view.discountedPriceController.text.isEmpty
                                      ? '0.0'
                                      : view.discountedPriceController.text),
                              style: AppTextStyles.medium
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(height: 20.h),
              const Divider(color: AppColor.blackColor),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Grand Total',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColor.blackColor),
                      )),
                  Spacer(),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              formatAmount((view.totalAmount -
                                      double.parse((view
                                              .discountedPriceController
                                              .text
                                              .isEmpty
                                          ? "0.0"
                                          : view
                                              .discountedPriceController.text)))
                                  .toString()),
                              style: AppTextStyles.largeBold
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(height: 20.h),
              const Divider(color: AppColor.blackColor),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: Button(
                onTap: () async {
                  Navigator.of(myContext!).pop();
                },
                leftPadding: 0,
                rightPading: 0,
                padding: 10.h,
                color: AppColor.whiteColor,
                borderColor: AppColor.blackColor,
                prefixIcon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColor.blackColor,
                  size: 18,
                ),
                buttonText: 'Back',
                textStyle: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
            ),
            SizedBox(width: 40.w),
            Expanded(
              child: Button(
                onTap: () {
                  view.createInvoice(
                    completion: () {
                      List<ModelPrinterProduct> listOfProducts = [];
                      for (var value in view.listOfScannedProducts) {
                        listOfProducts.add(
                          ModelPrinterProduct(
                            itemQty: value?.localQty.toString() ?? "1",
                            itemRate: formatAmount(
                                (value?.productDetail?.salePrice?.toString() ??
                                    "0.0")),
                            itemAmount: formatAmount(((double.parse((value
                                            ?.productDetail?.salePrice
                                            ?.toString() ??
                                        "0.0"))) *
                                    ((double.parse(
                                        value?.localQty.toString() ?? "0.0"))))
                                .toString()),
                            itemDescription: value?.productDetail?.name ?? "-",
                          ),
                        );
                      }

                      Navigator.of(myContext!).push(
                        MaterialPageRoute(
                          builder: (context) => SendAlertInvoiceGeneratedScreen(
                            key: key,
                            logo:
                                "http://207.244.105.191:8866${UserDefaults.getUserSession()?.branchDetail?.logo ?? ""}",
                            branchPhoneNo: UserDefaults.getUserSession()
                                    ?.branchDetail
                                    ?.phone ??
                                "-",
                            address: UserDefaults.getUserSession()
                                    ?.branchDetail
                                    ?.address ??
                                "",
                            salePersonName:
                                UserDefaults.getUserSession()?.firstName ?? "",
                            dateTime: view.dateTimeOfInvoice ?? "-",
                            customerName: view.modelUser?.name ?? "",
                            haveMail: (view.modelUser?.email ?? "").isNotEmpty
                                ? true
                                : false,
                            invoiceId: view.invoiceCreatedModel?.invoiceId ?? 0,
                            invoiceNumber:
                                view.invoiceCreatedModel?.invoiceNumber ?? "",
                            totalAmount: formatAmount((view.totalAmount -
                                    double.parse((view.discountedPriceController
                                            .text.isEmpty
                                        ? "0"
                                        : view.discountedPriceController.text)))
                                .toString()),
                            paymentMethod: paymentMethodName,
                            discount:
                                (view.discountedPriceController.text.isEmpty
                                    ? '0'
                                    : view.discountedPriceController.text),
                            listOfProducts: listOfProducts,
                            customerPhone: view.modelUser?.phone ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
                leftPadding: 0,
                rightPading: 0,
                padding: 10.h,
                postFixIcon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.whiteColor,
                  size: 18,
                ),
                color: AppColor.greenColor,
                borderColor: AppColor.greenColor,
                buttonText: 'Finish',
                textStyle: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.whiteColor),
              ),
            ),
          ],
        ),
        SizedBox(height: 500.h),
      ],
    );
  }

  String paymentMethodName = '';

  String getPaymentMethodIcon() {
    switch (view.selectedPaymentMethod) {
      case PaymentMethod.bt:
        paymentMethodName = "Bank Transfer";
        return 'assets/icons/icon-bank.svg';
      case PaymentMethod.cs:
        paymentMethodName = "Cash";
        return 'assets/icons/icon-cash.svg';
      case PaymentMethod.cc:
        paymentMethodName = "Credit Card";
        return 'assets/icons/icon-credit-card.svg';
    }
  }

  String getPaymentMethodName() {
    switch (view.selectedPaymentMethod) {
      case PaymentMethod.bt:
        return 'Bank';
      case PaymentMethod.cs:
        return 'Cash';

      case PaymentMethod.cc:
        return 'Credit Card';
    }
  }

  showDiscount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Discount',
          style: AppTextStyles.mediumBold.copyWith(color: AppColor.blackColor),
        ),
        SizedBox(height: 20.h),
        MyTextField(
          leftPadding: 0,
          controller: view.discountedPriceController,
          rightPadding: 0,
          keyboardType: TextInputType.number,
          hintText: 'Enter amount',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  view.calculateTotalAmount();
                },
                child: const Text("Add"))
          ],
        ),
        SizedBox(height: 20.h),
        const Divider(color: AppColor.blackColor),
      ],
    );
  }
}

void editName() {
  // AppPopUps.displayTextInputDialog(
  //     title: 'Change name',
  //     message: "Enter new name",
  //     hint: "New name",
  //     onSubmit: (String text) {
  //       if (text.isNotEmpty) {
  //         view.modelUser!.name = text;
  //         view.refresh();
  //       }
  //     });
}
