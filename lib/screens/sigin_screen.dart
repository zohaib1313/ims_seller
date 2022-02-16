import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/styles.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:ims_seller/view_models/sigin_screen_view_model.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class SignInScreen extends StatelessWidget {
  static const id = "SignInScreen";

  SignInScreen({Key? key}) : super(key: key);
  var view = Provider.of<SignInViewModel>(myContext!);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                child: Form(
                  key: view.formKey,
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
                        controller: view.userNameController,
                        hintText: 'Username',
                        validator: (string) {
                          if (string == null || string.isEmpty) {
                            return 'Enter Username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      MyTextField(
                        prefixIcon: AppAssets.passwordIc,
                        hintText: 'Password',
                        suffixIconWidet: GestureDetector(
                          onTap: () {
                            view.hidePassword = !view.hidePassword;
                          },
                          child: Icon(view.hidePassword
                              ? Icons.remove_red_eye_rounded
                              : Icons.visibility_off_outlined),
                        ),
                        controller: view.userPasswordController,
                        obsecureText: view.hidePassword,
                        validator: (string) {
                          if (string == null || string.isEmpty) {
                            return 'Enter Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Button(
                        buttonText: 'Login',
                        textColor: AppColor.whiteColor,
                        color: AppColor.blueColor,
                        onTap: () {
                          if (view.formKey.currentState!.validate()) {
                            view.singInUser(completion: () {
                              printWrapped('****Signed in*****');
                              Navigator.of(myContext!)
                                  .pushReplacementNamed(MainScreen.id);
                            });
                          }
                        },
                      ),
                      SizedBox(height: 80.h),
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
