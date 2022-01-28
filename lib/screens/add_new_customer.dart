import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';

import '../routes.dart';
import '../styles.dart';

class AddNewCustomer extends StatelessWidget {
  const AddNewCustomer({Key? key}) : super(key: key);
  static const id = "AddNewCustomer";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              top: 120.r, right: 120.r, left: 120.r, bottom: 50.r),
          child: Column(
            children: [
              getHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 150.h),
                      Text(
                        'New Customer',
                        style: AppTextStyles.largeBold
                            .copyWith(color: AppColor.blackColor),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Please add customer information',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.small.copyWith(
                            color: AppColor.blackColor, wordSpacing: 1.5),
                      ),
                      SizedBox(height: 50.h),
                      Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mobile Number*',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.mediumBold.copyWith(
                                    color: AppColor.blackColor,
                                    wordSpacing: 1.5),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColor.blackColor)),
                                    child: Text(
                                      '+959',
                                      style: AppTextStyles.small
                                          .copyWith(color: AppColor.blackColor),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: MyTextField(
                                      rightPadding: 0,
                                      leftPadding: 0,
                                      hintText: 'Enter Mobile Number',
                                      onChanged: (String text) {
                                        /*   if (text.isNotEmpty) {
                                    setState(() {
                                      isSearching = true;
                                    });
                                  } else {
                                    setState(() {
                                      isSearching = false;
                                    });
                                  }*/
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          getRow('Full Name*'),
                          SizedBox(height: 20.h),
                          getRow('Email Address'),
                          SizedBox(height: 20.h),
                          getRow('Membership No*'),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Button(
                            width: 800.w,
                            color: AppColor.blueColor,
                            textStyle: AppTextStyles.mediumBold
                                .copyWith(color: AppColor.whiteColor),
                            buttonText: 'Next',
                          ),
                        ),
                      )
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
          onTap: () {
            Navigator.of(myContext!).pop();
          },
          child: const SvgViewer(
            svgPath: 'assets/icons/icon-close.svg',
            height: 20,
            width: 20,
            color: AppColor.blackColor,
          ),
        ),
        SizedBox(width: 100.w),
        Text(
          "Sale Invoice",
          style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
        )
      ],
    );
  }

  getRow(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumBold
              .copyWith(color: AppColor.blackColor, wordSpacing: 1.5),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: MyTextField(
                rightPadding: 0,
                leftPadding: 0,
                hintText: 'Hla San Ei',
                onChanged: (String text) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
