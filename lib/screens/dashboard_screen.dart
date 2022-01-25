import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/screens/target_details_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../styles.dart';

class DashBoardScreen extends StatelessWidget {
  static const id = "Dashboard";

  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: Builder(
              builder: (cntx) => Container(
                    color: AppColor.blackColor,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100.w, vertical: 50.h),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 30.h, left: 100.w, right: 100.w),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(myContext!).pop();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 25,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                  const Text("Back",
                                      style: AppTextStyles.mediumBold)
                                ],
                              ),
                            ),
                            Center(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 50.h, left: 100.w, right: 100.w),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: 250.h,
                                  child: Card(
                                    elevation: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(100.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Top Sales",
                                                    style: AppTextStyles
                                                        .mediumBold
                                                        .copyWith(
                                                            color: AppColor
                                                                .blackColor),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SvgViewer(
                                                          svgPath:
                                                              'assets/icons/vertical_bar.svg'),
                                                      SizedBox(width: 50.w),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Total Amount",
                                                            style: AppTextStyles
                                                                .smallBold
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .blackColor),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SvgViewer(
                                                                  svgPath:
                                                                      'assets/icons/icon-money.svg'),
                                                              SizedBox(
                                                                  width: 50.w),
                                                              Expanded(
                                                                  child: Text(
                                                                "2357,00203",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles
                                                                    .smallBold
                                                                    .copyWith(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ))
                                                            ],
                                                          )
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SvgViewer(
                                                          svgPath:
                                                              'assets/icons/vertical_bar.svg'),
                                                      SizedBox(width: 50.w),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Total Amount",
                                                            style: AppTextStyles
                                                                .smallBold
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .blackColor),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SvgViewer(
                                                                  svgPath:
                                                                      'assets/icons/icon-money.svg'),
                                                              SizedBox(
                                                                  width: 50.w),
                                                              Expanded(
                                                                  child: Text(
                                                                "2357,00203",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles
                                                                    .smallBold
                                                                    .copyWith(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ))
                                                            ],
                                                          )
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: CircularPercentIndicator(
                                          radius: 300.r,
                                          lineWidth: 10.0,
                                          percent: 0.6,
                                          center: Text("100% \n Percentage",
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.smallBold
                                                  .copyWith(
                                                      color:
                                                          AppColor.blackColor)),
                                          progressColor: AppColor.blueColor,
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            MyTextField(
                              enable: false,
                              focusBorderColor: AppColor.greyColor,
                              hintText: 'Total Sales',
                              sufixLabel: '14',
                              prefixIcon: 'assets/icons/icon-invoice.svg',
                            ),
                            SizedBox(height: 20.h),
                            MyTextField(
                              enable: false,
                              focusBorderColor: AppColor.greyColor,
                              hintText: 'Total Discounts',
                              sufixLabel: '34000',
                              prefixIcon: 'assets/icons/icon-offer.svg',
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Button(
                                    onTap: () {
                                      Navigator.of(myContext!)
                                          .pushNamed(TargetDetailsScreen.id);
                                    },
                                    textColor: AppColor.whiteColor,
                                    buttonText: 'Stock Checking',
                                    color: AppColor.blueColor,
                                    textStyle: AppTextStyles.smallBold
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                  child: Button(
                                    buttonText: 'Search Customer',
                                    color: AppColor.greenColor,
                                    textStyle: AppTextStyles.smallBold
                                        .copyWith(fontSize: 14),
                                    onTap: () {
                                      Navigator.of(myContext!)
                                          .pushNamed(DashBoardScreen.id);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 100.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recent Sale Invoices",
                                    style: AppTextStyles.mediumBold
                                        .copyWith(color: AppColor.blackColor),
                                  ),
                                  Text(
                                    "View all",
                                    style: AppTextStyles.mediumBold
                                        .copyWith(color: AppColor.blueColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) =>
                                    getRowSalesInvoice(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))),
    );
  }

  getRowSalesInvoice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.greyColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1293993",
                    style: AppTextStyles.smallBold.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "1293993",
                    style: AppTextStyles.mediumBold
                        .copyWith(color: AppColor.blackColor, fontSize: 16),
                  ),
                ],
              ),
            ),
            Text(
              "1293993",
              style: AppTextStyles.mediumBold
                  .copyWith(color: AppColor.blackColor, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
