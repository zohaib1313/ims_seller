import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/screens/add_new_customer.dart';
import 'package:ims_seller/screens/dashboard_screen.dart';
import 'package:ims_seller/screens/search_customer_screen.dart';
import 'package:ims_seller/screens/sigin_screen.dart';
import 'package:ims_seller/styles.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:ims_seller/view_models/dashboard_view_model.dart';
import 'package:ims_seller/view_models/search_customer_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const id = 'Main_Screen';

  MainScreen({Key? key}) : super(key: key);

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

                    Navigator.of(myContext!).push(MaterialPageRoute(
                        builder: (context) => AddNewCustomer(
                              phoneNumber: "",
                            )));
                  },
                ),
                // ListTile(
                //   title: const Text("Add Product"),
                //   trailing: const Icon(Icons.arrow_forward),
                //   onTap: () {
                //     Navigator.of(myContext!).pop();
                //     Navigator.of(myContext!).pushNamed(AddNewProductScreen.id);
                //   },
                // ),
                ListTile(
                  title: const Text("Logout"),
                  trailing: const Icon(Icons.logout),
                  onTap: () {
                    UserDefaults().clearAll();
                    Navigator.of(myContext!).pop();
                    Navigator.of(myContext!)
                        .pushReplacementNamed(SignInScreen.id);
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
                                child: Text(
                                  "Hi, ${UserDefaults.getUserSession()?.username ?? ""}",
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
                                    Provider.of<AddNewProductViewModel>(
                                            myContext!,
                                            listen: false)
                                        .resetState();
                                    Provider.of<SearchCustomerViewModel>(
                                            myContext!,
                                            listen: false)
                                        .resetState();
                                    Navigator.of(myContext!)
                                        .pushNamed(SearchCustomerScreen.id);
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
                                    Provider.of<DashboardViewModel>(myContext!,
                                            listen: false)
                                        .resetState();
                                    Navigator.of(myContext!)
                                        .pushNamed(DashBoardScreen.id);
                                  },
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                // Button(
                                //   textColor: AppColor.whiteColor,
                                //   buttonText: 'Add Printing Device',
                                //   color: AppColor.greenColor,
                                //   onTap: () {
                                //     Navigator.of(myContext!).push(
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 AddPrintingDevice()));
                                //   },
                                // ),
                                // SizedBox(
                                //   height: 30.h,
                                // ),
                                /* Button(
                                  textColor: AppColor.whiteColor,
                                  buttonText: 'Print Test printing lib',
                                  color: AppColor.greenColor,
                                  onTap: () {
                                    List<ModelPrinterProduct> list = [];
                                    list.add(ModelPrinterProduct(
                                        itemDescription:
                                            "iPhone 13 128GB Pink (12456789)",
                                        itemQty: "1",
                                        itemRate: "12345",
                                        itemAmount: "12345"));

                                    list.add(ModelPrinterProduct(
                                        itemDescription:
                                            "iPhone 13 128GB Pink (12456789)",
                                        itemQty: "1",
                                        itemRate: "12345",
                                        itemAmount: "12345"));
                                    list.add(ModelPrinterProduct(
                                        itemDescription:
                                            "iPhone 13 128GB Pink (12456789)",
                                        itemQty: "1",
                                        itemRate: "12345",
                                        itemAmount: "12345"));
                                    list.add(ModelPrinterProduct(
                                        itemDescription:
                                            "iPhone 13 128GB Pink (12456789)",
                                        itemQty: "1",
                                        itemRate: "12345",
                                        itemAmount: "12345"));
                                    list.add(ModelPrinterProduct(
                                        itemDescription:
                                            "iPhone 13 128GB Pink (12456789)",
                                        itemQty: "1",
                                        itemRate: "12345",
                                        itemAmount: "12345"));
                                    list.add(ModelPrinterProduct(
                                        itemDescription:
                                            "iPhone 13 128GB Pink (12456789)",
                                        itemQty: "1",
                                        itemRate: "12345",
                                        itemAmount: "12345"));
                                    list.add(ModelPrinterProduct(
                                        itemDescription:
                                            "iPhone 13 128GB Pink (12456789)",
                                        itemQty: "1",
                                        itemRate: "12345",
                                        itemAmount: "12345"));

                                    //CustomPrinter().print(list);
                                    MyPrinting().doPrint(
                                        title: "mDrive(Kabar Aye)",
                                        address:
                                            "no.81, Kabar Aye Pagoda Road, Bahan Township",
                                        stringPhoneNo: "+09000000",
                                        invoiceNumber: "Invoice# S-KBA-19906",
                                        dateTime:
                                            "Wednesday,February 2nd 2022, 2:02:54 pm",
                                        salePersonName: "Shwe",
                                        customer: "12312-Thent Htar Zaw",
                                        paymentMethod: "Cash",
                                        totalAmount: formatAmount("1927500.0"),
                                        discount: formatAmount("929492.0"),
                                        numberOfItems: "4",
                                        listOfProducts: list);
                                  },
                                ),*/
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
