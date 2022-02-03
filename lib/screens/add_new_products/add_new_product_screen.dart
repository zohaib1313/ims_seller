import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/add_new_customer_model.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../styles.dart';
import '../invoice_summary_screen.dart';
import '../search_customer_screen.dart';
import 'add_new_product_views.dart';

class AddNewProductScreenNew extends StatefulWidget {
  CustomerModel customerModel;

  AddNewProductScreenNew({Key? key, required this.customerModel})
      : super(key: key);

  @override
  State<AddNewProductScreenNew> createState() => _AddNewProductScreenNewState();
}

class _AddNewProductScreenNewState extends State<AddNewProductScreenNew> {
  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);

  @override
  void initState() {
    super.initState();
    view.modelUser = widget.customerModel;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Provider.of<AddNewProductViewModel>(context, listen: false)
            .goBackwards();
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
                        GestureDetector(
                          onTap: () {
                            AppPopUps.showConfirmDialog(
                                title: "Alert",
                                message: "Are you sure you want to change user",
                                onSubmit: () {
                                  Navigator.of(myContext!).pushReplacementNamed(
                                      SearchCustomerScreen.id);
                                });
                          },
                          child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Customer Name:",
                                        style: AppTextStyles.small.copyWith(
                                            color: AppColor.whiteColor),
                                      ),
                                      Text(
                                        view.modelUser?.name ?? '',
                                        style: AppTextStyles.smallBold.copyWith(
                                            color: AppColor.whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(flex: 2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SvgViewer(
                                        svgPath: 'assets/icons/edit_icon.svg'),
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
                        ),
                        SizedBox(height: 30.h),
                        relevantViewReturner(myContext!),
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
                            print("got product result");
                            if (view.currentView != Views.listProducts) {
                              print("forward to list products");
                              view.goForwards(Views.listProducts);
                            } else if (view.currentView == Views.listProducts) {
                              print("current view not list product");
                            }
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
                              printWrapped(view.currentView.name);
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
                                      PaymentMethod.bt) {
                                view.goForwards(Views.bankPaymentDetails);
                              } else if (view.currentView ==
                                      Views.bankPaymentDetails &&
                                  view.selectedBank != null &&
                                  view.selectedBankTransactionIdController.text
                                      .isNotEmpty) {
                                Navigator.of(myContext!)
                                    .pushNamed(InvoiceSummaryScreen.id);
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

  Widget relevantViewReturner(context) {
    print("returning new sceen ${view.currentView.name}");

    switch (Provider.of<AddNewProductViewModel>(context, listen: true)
        .currentView) {
      case Views.scanProduct:
        return scanProductView(view);
      case Views.listProducts:
        return productListView(view);
      case Views.selectPayment:
        return selectPaymentView(view);
      case Views.bankPaymentDetails:
        return bankPaymentDetails(view);
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
}

/*
class AddNewProductScreen extends StatefulWidget {
  static var id = "product";
  CustomerModel customerModel;

  AddNewProductScreen({Key? key, required this.customerModel})
      : super(key: key);

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);

  @override
  void initState() {
    super.initState();
    view.modelUser = widget.customerModel;
    view.getPaymentMethods();
    view.getNotificationMethods();
  }


}
*/
