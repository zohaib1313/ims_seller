import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';

import '../routes.dart';
import '../styles.dart';

class SearchCustomerScreen extends StatefulWidget {
  const SearchCustomerScreen({Key? key}) : super(key: key);
  static const id = "SearchCustomerId";

  @override
  State<SearchCustomerScreen> createState() => _SearchCustomerScreenState();
}

class _SearchCustomerScreenState extends State<SearchCustomerScreen> {
  bool isSearching = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(120.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getHeader(),
              SizedBox(height: 150.h),
              Text(
                'Search Customer',
                style: AppTextStyles.largeBold
                    .copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 10.h),
              Text(
                'Add customer mobile number\nto check the customer registration',
                textAlign: TextAlign.center,
                style: AppTextStyles.small
                    .copyWith(color: AppColor.blackColor, wordSpacing: 1.5),
              ),
              SizedBox(height: 50.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(30.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.blackColor)),
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
              isSearching
                  ? showSearchList()
                  : Container(
                      margin: EdgeInsets.only(top: 50.h),
                      padding: EdgeInsets.all(80.r),
                      decoration: BoxDecoration(
                          color: AppColor.blueColor,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.search,
                        size: 150.r,
                        color: AppColor.whiteColor,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  showSearchList() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.blackColor),
                borderRadius: BorderRadius.circular(12)),
            child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    getSearchItem(true),
                    getSearchItem(false),
                    getSearchItem(false),
                    getSearchItem(false),
                    getSearchItem(false),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  getSearchItem(bool showClearButton) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hisham Ali"),
            showClearButton ? Icon(Icons.clear) : IgnorePointer()
          ],
        ),
        const Text("+92456789"),
        const Divider(
          color: AppColor.blackColor,
        )
      ],
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
}
