import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/screens/add_new_customer.dart';
import 'package:ims_seller/screens/dashboard_screen.dart';
import 'package:ims_seller/screens/invoice_new_screen.dart';
import 'package:ims_seller/screens/search_customer_screen.dart';
import 'package:ims_seller/styles.dart';

class MainScreen extends StatelessWidget {
  static const id = 'Main_Screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text("Search Customer"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(myContext!).pop();
                    Navigator.of(myContext!).pushNamed(SearchCustomerScreen.id);
                  },
                ),
                ListTile(
                  title: const Text("Add New Customer"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(myContext!).pop();
                    Navigator.of(myContext!).pushNamed(AddNewCustomer.id);
                  },
                ),
              ],
            ),
          ),
          body: Builder(
              builder: (cntx) => Container(
                    color: AppColor.blackColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(100.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Scaffold.of(cntx).openDrawer();
                                },
                                child: const Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 20.h, bottom: 20.h),
                                child: const Text(
                                  'Hi, Hanna Broun',
                                  style: AppTextStyles.largeBold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 100.w, vertical: 50.h),
                            child: Column(
                              children: [
                                Button(
                                  onTap: () {
                                    Navigator.of(myContext!)
                                        .pushNamed(InvoiceNewScreen.id);
                                  },
                                  textColor: AppColor.whiteColor,
                                  buttonText: 'New Invoice',
                                  color: AppColor.blueColor,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Button(
                                  textColor: AppColor.whiteColor,
                                  buttonText: 'Dashboard',
                                  color: AppColor.greenColor,
                                  onTap: () {
                                    Navigator.of(myContext!)
                                        .pushNamed(DashBoardScreen.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
