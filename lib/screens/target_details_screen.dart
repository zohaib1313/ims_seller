import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../routes.dart';
import '../styles.dart';

class TargetDetailsScreen extends StatefulWidget {
  const TargetDetailsScreen({Key? key}) : super(key: key);
  static const id = "Target_Details";

  @override
  _TargetDetailsScreenState createState() => _TargetDetailsScreenState();
}

class _TargetDetailsScreenState extends State<TargetDetailsScreen> {
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
                            const Spacer(),
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
                            Expanded(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) =>
                                    getRowSalesInvoice(),
                              ),
                            )
                          ],
                        )
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "IPAD",
              style: AppTextStyles.mediumBold.copyWith(
                  color: AppColor.blackColor, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Target",
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "40",
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Achieved",
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "40",
                        style: AppTextStyles.mediumBold
                            .copyWith(color: AppColor.blackColor, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 150.r,
                    lineWidth: 5.0,
                    percent: 0.2,
                    center: Text("100% \n Percentage",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.smallBold
                            .copyWith(color: AppColor.blackColor, fontSize: 8)),
                    progressColor: AppColor.blueColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
