import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/search_result_model.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../styles.dart';
import 'invoice_summary_screen.dart';

class AddNewProductScreen extends StatelessWidget {
  static const id = 'AddNewProductScreen';
  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);

  SearchResultModel? modelUser;

  AddNewProductScreen({Key? key}) : super(key: key);

  AddNewProductScreen.user({this.modelUser});

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
                                      style: AppTextStyles.smallBold
                                          .copyWith(color: AppColor.whiteColor),
                                    ),
                                    Text(
                                      modelUser?.name ?? '',
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
                                  const SvgViewer(
                                      svgPath: 'assets/icons/edit_icon.svg'),
                                  const SizedBox(height: 3),
                                  Text(
                                    modelUser?.phone ?? '',
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

  scanProductView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Scan Product",
          style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
        ),
        SizedBox(height: 20.h),
        const Center(
          child: SvgViewer(
            svgPath: 'assets/icons/scan_hand_ic.svg',
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  productListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product List",
          style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
        ),
        SizedBox(height: 20.h),
        Center(
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(20.h),
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.whiteColor),
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "123543388",
                            style: AppTextStyles.small
                                .copyWith(color: AppColor.blackColor),
                          ),
                          Text(
                            "iPhone 13 Pro 256 GB Red",
                            style: AppTextStyles.small
                                .copyWith(color: AppColor.blackColor),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "",
                                  style: AppTextStyles.mediumBold
                                      .copyWith(color: AppColor.blackColor),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "MMK: 27,550293",
                                  style: AppTextStyles.mediumBold
                                      .copyWith(color: AppColor.blackColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.h),
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.whiteColor),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "123543388",
                            style: AppTextStyles.small
                                .copyWith(color: AppColor.blackColor),
                          ),
                          Text(
                            "iPhone 13 Pro Leather Cover",
                            style: AppTextStyles.small
                                .copyWith(color: AppColor.blackColor),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "90,000 * 2",
                                  style: AppTextStyles.medium
                                      .copyWith(color: AppColor.blackColor),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "MMK: 27,550293",
                                    style: AppTextStyles.mediumBold.copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                color: AppColor.blackColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: const Icon(
                              Icons.add,
                              color: AppColor.whiteColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: AppColor.alphaGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Text(
                              '2',
                              style: AppTextStyles.medium
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                color: AppColor.blackColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: const Icon(
                              Icons.remove,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  selectPaymentView() {
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
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  Expanded(
                    child: getPaymentMethodItem(
                        title: 'Cash',
                        icon: 'assets/icons/icon-cash.svg',
                        isSelected: false),
                  ),
                  Expanded(
                    child: getPaymentMethodItem(
                        title: 'Credit Card',
                        icon: 'assets/icons/icon-credit-card.svg',
                        isSelected: false),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: getPaymentMethodItem(
                        title: 'Bank Transfer',
                        icon: 'assets/icons/icon-bank.svg',
                        isSelected: true),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
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
                      if (view.currentView != Views.listProducts) {
                        view.getProductDetails(completion: () {
                          view.goForwards(Views.listProducts);
                        }, code: id);...
                      }
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
                    children: const [
                      Text(
                        '27,00.00',
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
                              if (view.currentView == Views.scanProduct) {
                                view.goForwards(Views.listProducts);
                              } else if (view.currentView ==
                                  Views.listProducts) {
                                view.goForwards(Views.selectPayment);
                              } else if (view.currentView ==
                                      Views.selectPayment &&
                                  view.selectedPaymentMethod ==
                                      PaymentMethod.bank) {
                                view.goForwards(Views.bankPaymentDetails);
                              } else {
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

  getPaymentMethodItem(
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

  bankPaymentDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bank Transfer",
          style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
        ),
        SizedBox(height: 20.h),
        Center(
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Text(
                'Select Bank *',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 10.h),
              MyDropDown(
                  rightPadding: 0,
                  leftPadding: 0,
                  onChange: (value) {},
                  borderColor: AppColor.blackColor,
                  hintColor: AppColor.blackColor,
                  labelColor: AppColor.blackColor,
                  hintText: 'Select Bank',
                  items: ['A', 'B'],
                  validator: (string) {
                    if (string == null) {
                      return "select bank";
                    }
                  }),
              SizedBox(height: 20.h),
              Text(
                'Transaction No. *',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 10.h),
              MyTextField(
                leftPadding: 0,
                rightPadding: 0,
                hintText: '123456789',
              ),
              SizedBox(height: 20.h),
              /*   Text(
                'Upload Receipt ',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 20.h),
              Button(
                onTap: () {},
                leftPadding: 0,
                rightPading: 0,
                padding: 10.h,
                color: AppColor.whiteColor,
                borderColor: AppColor.blackColor,
                buttonText: 'Upload',
                textStyle: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),*/
              SizedBox(height: 200.h),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
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
}
