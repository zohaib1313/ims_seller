import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/screens/add_new_products/add_new_product_views.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:ims_seller/view_models/search_customer_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../styles.dart';
import 'invoice_summary_screen.dart';

class AddNewProductScreen extends StatelessWidget {
  static const id = 'AddNewProductScreen';
  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);

  AddNewProductScreen() {
    view.modelUser =
        Provider.of<SearchCustomerViewModel>(myContext!, listen: true)
            .selectedUser;
    view.getPaymentMethods();
    view.getNotificationMethods();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return view.goBackwards();
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.only(top: 120.r, left: 120.r, right: 120.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
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
                                  GestureDetector(
                                    onTap: () {
                                      editName();
                                    },
                                    child: const SvgViewer(
                                        svgPath: 'assets/icons/edit_icon.svg'),
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
                        relevantViewReturner(view),
                      ],
                    ),
                  ),
                ),
                bottomView(),
              ],
            ),
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
            if (await view.goBackwards()) {
              Navigator.of(myContext!).pop();
            }
          },
          child: const SvgViewer(
            svgPath: 'assets/icons/icon-arrow-back.svg',
            height: 25,
            width: 25,
            color: AppColor.blackColor,
          ),
        ),
        SizedBox(width: 100.w),
        Text(
          view.getHeaderText(),
          style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
        )
      ],
    );
  }

  bottomView() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: view.currentView == Views.scanProduct ||
                    view.currentView == Views.listProducts,
                child: FloatingActionButton(
                  backgroundColor: AppColor.greenColor,
                  onPressed: () {
                    //  view.currentView = (Views.listProducts);
                    view.scanBarcodeNormal(completion: (id) {
                      print("*****printing barcode*******");

                      view.getProductDetails(
                          completion: () {
                            if (view.currentView != Views.listProducts) {
                              view.goForwards(Views.listProducts);
                            } else if (view.currentView ==
                                Views.listProducts) {}
                          },
                          code: id);
                    });
                  },
                  child: const SvgViewer(
                    svgPath: 'assets/icons/icon-scan-qr.svg',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              view.isExpanded = !view.isExpanded;
            },
            child: Container(
              padding: EdgeInsets.only(left: 20.h, right: 20, top: 20),
              decoration: const BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        'Total Amount',
                        style: AppTextStyles.medium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        view.totalAmount.toString(),
                        style: AppTextStyles.largeBold,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const Divider(color: AppColor.whiteColor),
                  SizedBox(height: 10.h),
                  ExpandableCardContainer(
                    isExpanded: view.isExpanded,
                    collapsedChild: IgnorePointer(),
                    expandedChild: Row(
                      children: [
                        Expanded(
                          child: Button(
                            onTap: () async {
                              if (await view.goBackwards()) {
                                Navigator.of(myContext!).pop();
                              }
                            },
                            leftPadding: 0,
                            rightPading: 0,
                            padding: 10.h,
                            color: AppColor.blackColor,
                            borderColor: AppColor.whiteColor,
                            prefixIcon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColor.whiteColor,
                              size: 18,
                            ),
                            buttonText: 'Back',
                            textStyle: AppTextStyles.mediumBold
                                .copyWith(color: AppColor.whiteColor),
                          ),
                        ),
                        SizedBox(width: 40.w),
                        Expanded(
                          child: Button(
                            onTap: () {
                              if (view.currentView == Views.scanProduct &&
                                  view.listOfScannedProducts.isNotEmpty) {
                                view.goForwards(Views.listProducts);
                              } else if (view.currentView ==
                                      Views.listProducts &&
                                  view.listOfScannedProducts.isNotEmpty) {
                                view.goForwards(Views.selectPayment);
                              } else if (view.currentView ==
                                      Views.selectPayment &&
                                  view.selectedPaymentMethod ==
                                      PaymentMethod.bank) {
                                view.goForwards(Views.bankPaymentDetails);
                              } else if (view.currentView ==
                                  Views.selectPayment) {
                                Navigator.of(myContext!)
                                    .pushNamed(InvoiceSummaryScreen.id);
                              }
                            },
                            leftPadding: 0,
                            rightPading: 0,
                            padding: 10.h,
                            postFixIcon: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColor.whiteColor,
                              size: 18,
                            ),
                            color: AppColor.blueColor,
                            borderColor: AppColor.blueColor,
                            buttonText: 'Next',
                            textStyle: AppTextStyles.mediumBold
                                .copyWith(color: AppColor.whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  relevantViewReturner(AddNewProductViewModel view) {
    switch (view.currentView) {
      case Views.scanProduct:
        return scanProductView();
      case Views.listProducts:
        return productListView();
      case Views.selectPayment:
        return selectPaymentView();

      case Views.bankPaymentDetails:
        return bankPaymentDetails();
    }
  }

  void editName() {
    AppPopUps.displayTextInputDialog(
        title: 'Change name',
        message: "Enter new name",
        hint: "New name",
        onSubmit: (String text) {
          if (text.isNotEmpty) {
            view.modelUser!.name = text;
            view.refresh();
          }
        });
  }
}
