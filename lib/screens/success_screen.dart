import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';

import '../styles.dart';

class SuccessScreen extends StatelessWidget {
  static const id = 'SuccessScreen';
  String title;

  SuccessScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            title,
            style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    )));
  }
}
