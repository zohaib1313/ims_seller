import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/ModelSalesTarget.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../routes.dart';
import '../styles.dart';

class TargetDetailsScreen extends StatefulWidget {
  ModelSalesTarget _modelSalesTarget;

  TargetDetailsScreen(this._modelSalesTarget);

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(myContext!).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 30.h, left: 100.w, right: 100.w),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      size: 25,
                                      color: AppColor.whiteColor,
                                    ),
                                    Text("Back",
                                        style: AppTextStyles.mediumBold),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.h, left: 100.w, right: 100.w),
                              child: Text(
                                "Hi, ${UserDefaults.getUserSession()?.username ?? ""}",
                                style: AppTextStyles.largeBold
                                    .copyWith(color: AppColor.whiteColor),
                              ),
                            ),
                            Center(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 20.h, left: 100.w, right: 100.w),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: 250.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.r),
                                          topRight: Radius.circular(350.r),
                                          bottomLeft: Radius.circular(50.r),
                                          bottomRight: Radius.circular(50.r)),
                                    ),
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
                                                        .smallBold
                                                        .copyWith(
                                                            color: AppColor
                                                                .blackColor),
                                                  ),
                                                ),
                                                Flexible(
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
                                                                .small
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
                                                              Flexible(
                                                                  child: Text(
                                                                formatAmount(widget
                                                                    ._modelSalesTarget
                                                                    .totalSaleAmount
                                                                    .toString()),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles.smallBold.copyWith(
                                                                    color: AppColor
                                                                        .blackColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                                            "Total Quantity",
                                                            style: AppTextStyles
                                                                .small
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .blackColor),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SvgViewer(
                                                                  svgPath:
                                                                      'assets/icons/quantity_ic.svg'),
                                                              SizedBox(
                                                                  width: 50.w),
                                                              Expanded(
                                                                  child: Text(
                                                                widget
                                                                    ._modelSalesTarget
                                                                    .totalSaleQty
                                                                    .toString(),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles.smallBold.copyWith(
                                                                    color: AppColor
                                                                        .blackColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 80.r,
                                              right: 80.r,
                                              bottom: 80.r),
                                          child: CircularPercentIndicator(
                                            radius: 300.r,
                                            lineWidth: 10.0,
                                            percent: ((widget._modelSalesTarget
                                                            .totalAchivement
                                                            ?.toDouble() ??
                                                        0.0) >
                                                    100.0)
                                                ? 1.0
                                                : ((widget._modelSalesTarget
                                                            .totalAchivement
                                                            ?.toDouble() ??
                                                        0.0) /
                                                    100),
                                            center: Text(
                                                "${widget._modelSalesTarget.totalAchivement.toString()}% \n Target",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.smallBold
                                                    .copyWith(
                                                        color: AppColor
                                                            .blackColor)),
                                            progressColor: AppColor.blueColor,
                                          ),
                                        )
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
                                  itemCount: widget
                                          ._modelSalesTarget.targets?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    if (widget._modelSalesTarget.targets !=
                                            null &&
                                        widget._modelSalesTarget.targets!
                                            .isNotEmpty) {
                                      return getRowSalesInvoice(widget
                                          ._modelSalesTarget.targets![index]);
                                    } else {
                                      return Container();
                                    }
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ))),
    );
  }

  getRowSalesInvoice(Targets target) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.5, color: AppColor.greyColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        target.name.toString(),
                        style: AppTextStyles.mediumBold.copyWith(
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "Target",
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        target.targetAmount.toString(),
                        style: AppTextStyles.mediumBold
                            .copyWith(color: AppColor.blackColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '',
                        style: AppTextStyles.mediumBold.copyWith(
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "Achieved",
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        target.achivedAmount.toString(),
                        style: AppTextStyles.mediumBold
                            .copyWith(color: AppColor.blackColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 200.r,
                    lineWidth: 6.0,
                    percent: ((target.percentage?.toDouble() ?? 0.0) > 100.0)
                        ? 1.0
                        : ((target.percentage?.toDouble() ?? 0.0) / 100),
                    center: Text("${target.percentage}%",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumBold.copyWith(
                            color: AppColor.blackColor, fontSize: 10)),
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
