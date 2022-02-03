import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes.dart';
import '../styles.dart';

class ViewAllInvoiceScreen extends StatelessWidget {
  ViewAllInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(myContext!).pop();
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 30.h, left: 100.w, right: 100.w),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: AppColor.blackColor,
                      ),
                      Text("Back",
                          style: AppTextStyles.mediumBold
                              .copyWith(color: AppColor.blackColor))
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
}
