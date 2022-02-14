import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/add_new_customer_model.dart';
import 'package:ims_seller/view_models/add_new_customer_view_model.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../styles.dart';
import 'add_new_products/add_new_product_screen.dart';

class AddNewCustomer extends StatefulWidget {
  static const id = "AddNewCustomer";
  String? phoneNumber;

  AddNewCustomer({this.phoneNumber});

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  var view = Provider.of<AddNewCustomerViewModel>(myContext!);

  @override
  void initState() {
    super.initState();
    view.mobileNumberEditingController.text = widget.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return view.resetState();
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(
                top: 120.r, right: 120.r, left: 120.r, bottom: 50.r),
            child: Column(
              children: [
                getHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                        Form(
                          key: view.formKey,
                          child: Column(
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: AppColor.blackColor)),
                                        child: Text(
                                          '+959',
                                          style: AppTextStyles.small.copyWith(
                                              color: AppColor.blackColor),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: MyTextField(
                                          rightPadding: 0,
                                          controller: view
                                              .mobileNumberEditingController,
                                          leftPadding: 0,
                                          keyboardType: TextInputType.phone,
                                          hintText: 'Enter Mobile Number',
                                          // validator: (string) {
                                          //   if (string == null ||
                                          //       string.isEmpty) {
                                          //     return 'Enter Mobile Number';
                                          //   }
                                          //   return null;
                                          // },
                                          onChanged: (String text) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              getRow('Full Name*',
                                  view.fullNameEditingTextController, true),
                              SizedBox(height: 20.h),
                              getRow('Email Address',
                                  view.emailAddressController, false),
                              SizedBox(height: 20.h),
                              getRow('City', view.cityController, false),
                              SizedBox(height: 20.h),
                              getRow('Address', view.addressController, false),
                              /*    SizedBox(height: 20.h),
                              getRow('Membership No*',
                                  view.memberShipNumberEditingController, true),*/
                            ],
                          ),
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
                              onTap: () {
                                if (view.formKey.currentState!.validate()) {
                                  view.addNewUser(
                                    completion: (CustomerModel user) {
                                      view.resetState();
                                      Provider.of<AddNewProductViewModel>(
                                              myContext!,
                                              listen: false)
                                          .resetState();

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AddNewProductScreenNew(
                                                  customerModel: user),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
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
      ),
    );
  }

  getHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            view.resetState();
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

  getRow(
      String title, TextEditingController controller, bool enableValidation) {
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
                controller: controller,
                leftPadding: 0,
                hintText: '',
                onChanged: (String text) {},
                validator: enableValidation
                    ? ((string) {
                        if (string == null || string.isEmpty) {
                          return 'Enter $title';
                        }
                        return null;
                      })
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
