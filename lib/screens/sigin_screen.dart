import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/screens/main_screen.dart';
import 'package:ims_seller/styles.dart';

class SignInScreen extends StatelessWidget {
  static const id = "SignInScreen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0.r),
                child: SvgViewer(
                  svgPath: AppAssets.appLogo,
                  height: 350.h,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 20.h, bottom: 150.h, left: 150.w, right: 150.w),
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(50.r)),
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    SvgViewer(
                      svgPath: AppAssets.lockIc,
                      height: 160.h,
                    ),
                    SizedBox(height: 20.h),
                    MyTextField(
                      prefixIcon: AppAssets.userIcon,
                      hintText: 'Username',
                    ),
                    SizedBox(height: 20.h),
                    MyTextField(
                      prefixIcon: AppAssets.passwordIc,
                      hintText: 'Password',
                    ),
                    SizedBox(height: 20.h),
                    Button(
                      buttonText: 'Login',
                      textColor: AppColor.whiteColor,
                      color: AppColor.blueColor,
                      onTap: () {
                        Navigator.of(myContext!)
                            .pushReplacementNamed(MainScreen.id);
                      },
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
