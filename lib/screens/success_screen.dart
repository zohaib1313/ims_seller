import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../styles.dart';

class SuccessScreen extends StatefulWidget {
  static const id = 'SuccessScreen';
  String title;
  bool printt;

  SuccessScreen({required this.title, required this.printt});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
            height: 550.r,
            width: 550.r,
          ),
          SizedBox(height: 10.h),
          Text(
            widget.title,
            style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
          ),
          SizedBox(height: 10.h),
          SizedBox(height: 10.h),
          Visibility(
            visible:
                Provider.of<AddNewProductViewModel>(myContext!, listen: false)
                    .selectedNotificationMethods
                    .contains(NotificationMethods.print),
            child: InkWell(
              onTap: () {
                Provider.of<AddNewProductViewModel>(myContext!, listen: false)
                    .doPrint();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Print",
                  style: AppTextStyles.mediumBold
                      .copyWith(color: AppColor.blackColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    )));
  }

  @override
  void initState() {
    super.initState();
    // Timer(
    //   const Duration(seconds: 3),
    //   () => {
    //     if (widget.printt)
    //       {
    //         Provider.of<AddNewProductViewModel>(myContext!, listen: false)
    //             .doPrint()
    //       },
    //   },
    // );
  }
}
