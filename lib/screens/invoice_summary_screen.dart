import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/screens/send_alert_screen.dart';

import '../routes.dart';
import '../styles.dart';

class InvoiceSummaryScreen extends StatelessWidget {
  const InvoiceSummaryScreen({Key? key}) : super(key: key);

  static const id = 'InvoiceSummaryScreen';
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
                                const SvgViewer(
                                    svgPath: 'assets/icons/edit_icon.svg'),
                                const SizedBox(height: 3),
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
                      productListView()
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
          child: const SvgViewer(
            svgPath: 'assets/icons/icon-arrow-back.svg',
            height: 25,
            width: 25,
            color: AppColor.blackColor,
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
                          const Flexible(
                            child: SvgViewer(
                              svgPath: 'assets/icons/icon-cash.svg',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          SizedBox(width: 50.w),
                          Flexible(
                            child: Text(
                              'Cash',
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
              Text(
                'Add Discount',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 20.h),
              MyTextField(
                leftPadding: 0,
                rightPadding: 0,
                hintText: 'Enter amount',
              ),
              SizedBox(height: 20.h),
              const Divider(color: AppColor.blackColor),
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
                              '2,75,999',
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
                              '50,000',
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
                              '27,0000',
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
                  Navigator.of(myContext!)
                      .pushNamed(SendAlertInvoiceGeneratedScreen.id);
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
}
