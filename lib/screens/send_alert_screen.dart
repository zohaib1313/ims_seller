import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/styles.dart';

class SendAlertInvoiceGeneratedScreen extends StatelessWidget {
  const SendAlertInvoiceGeneratedScreen({Key? key}) : super(key: key);
  static const id = "invoiceGeneratedAlert";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                  style:
                      AppTextStyles.large.copyWith(color: AppColor.blackColor),
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
                Expanded(
                  child: Center(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: getSendAlertMethodItem(
                                  title: 'SMS',
                                  icon: 'assets/icons/icon-sms.svg',
                                  isSelected: true),
                            ),
                            Expanded(
                              child: getSendAlertMethodItem(
                                  title: 'Email',
                                  icon: 'assets/icons/icon-mail.svg',
                                  isSelected: false),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: getSendAlertMethodItem(
                                  title: 'Print',
                                  icon: 'assets/icons/icon-printer.svg',
                                  isSelected: false),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Button(
                  onTap: () {},
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
                SizedBox(height: 20.h),
              ],
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
