import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/ModelSalesTarget.dart';
import 'package:ims_seller/models/invoice_sale_model.dart';
import 'package:ims_seller/models/model_invoice_merchat.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/screens/sale_invoice_screen.dart';
import 'package:ims_seller/screens/target_details_screen.dart';
import 'package:ims_seller/screens/view_all_invoices_screen.dart';
import 'package:ims_seller/utils/user_defaults.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:ims_seller/view_models/dashboard_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class DashBoardScreen extends StatefulWidget {
  static const id = "Dashboard";

  DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Stream<List<ModelInvoiceMerchant>>? resentSalesInvoicesStream;
  Stream<ModelSalesTarget>? invoiceTargetStream;
  var view = Provider.of<DashboardViewModel>(myContext!);

  @override
  void initState() {
    super.initState();
    invoiceTargetStream = view.getInvoiceTargets();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Builder(
          builder: (cntx) => StreamBuilder(
              stream: invoiceTargetStream,
              builder: (BuildContext context,
                  AsyncSnapshot<ModelSalesTarget> snapshot) {
                resentSalesInvoicesStream =
                    view.getMerchantInvoiceList(start: 0, end: 10);
                if (snapshot.data != null) {
                  var data = snapshot.data!;
                  return Container(
                    color: AppColor.blackColor,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100.w, vertical: 50.h),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(myContext!).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 30.h, left: 100.w, right: 100.w),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      size: 25,
                                      color: AppColor.whiteColor,
                                    ),
                                    Text("Back",
                                        style: AppTextStyles.mediumBold)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.h, left: 100.w, right: 100.w),
                              child: Text(
                                "Hi, ${UserDefaults.getUserSession()?.username ?? ""}",
                                style: AppTextStyles.largeBold
                                    .copyWith(color: AppColor.whiteColor),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 20.h, left: 100.w, right: 100.w),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50)),
                                height: 250.h,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TargetDetailsScreen(data),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.r),
                                          topRight: Radius.circular(350.r),
                                          bottomLeft: Radius.circular(50.r),
                                          bottomRight: Radius.circular(50.r)),
                                    ),
                                    elevation: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(100.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Top Sales",
                                                    style: AppTextStyles
                                                        .smallBold
                                                        .copyWith(
                                                            color: AppColor
                                                                .blackColor),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SvgViewer(
                                                          svgPath:
                                                              'assets/icons/vertical_bar.svg'),
                                                      SizedBox(width: 50.w),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Total Amount",
                                                            style: AppTextStyles
                                                                .small
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .blackColor),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SvgViewer(
                                                                  svgPath:
                                                                      'assets/icons/icon-money.svg'),
                                                              SizedBox(
                                                                  width: 50.w),
                                                              Expanded(
                                                                  child: Text(
                                                                formatAmount(data
                                                                    .totalSaleAmount
                                                                    .toString()),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles.smallBold.copyWith(
                                                                    color: AppColor
                                                                        .blackColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ))
                                                            ],
                                                          )
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SvgViewer(
                                                          svgPath:
                                                              'assets/icons/vertical_bar.svg'),
                                                      SizedBox(width: 50.w),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Total Quantity",
                                                            style: AppTextStyles
                                                                .small
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .blackColor),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SvgViewer(
                                                                  svgPath:
                                                                      'assets/icons/quantity_ic.svg'),
                                                              SizedBox(
                                                                  width: 50.w),
                                                              Expanded(
                                                                  child: Text(
                                                                data.totalSaleQty
                                                                    .toString(),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles.smallBold.copyWith(
                                                                    color: AppColor
                                                                        .blackColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ))
                                                            ],
                                                          )
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 80.r,
                                              right: 80.r,
                                              bottom: 80.r),
                                          child: CircularPercentIndicator(
                                            radius: 300.r,
                                            lineWidth: 10.0,
                                            percent: ((data.totalAchivement
                                                            ?.toDouble() ??
                                                        0.0) >
                                                    100.0)
                                                ? 1.0
                                                : ((data.totalAchivement
                                                            ?.toDouble() ??
                                                        0.0) /
                                                    100),
                                            center: Text(
                                                "${data.totalAchivement.toString()}% \n Target",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.smallBold
                                                    .copyWith(
                                                        color: AppColor
                                                            .blackColor)),
                                            progressColor: AppColor.blueColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    MyTextField(
                                      enable: false,
                                      contentPadding: 10,
                                      focusBorderColor: AppColor.greyColor,
                                      hintText: 'Total Sales',
                                      hintColor: AppColor.blackColor,
                                      sufixLabel:
                                          '${data.totalSale.toString()}',
                                      prefixIcon:
                                          'assets/icons/icon-invoice.svg',
                                    ),
                                    SizedBox(height: 20.h),
                                    MyTextField(
                                      enable: false,
                                      contentPadding: 10,
                                      hintColor: AppColor.blackColor,
                                      focusBorderColor: AppColor.greyColor,
                                      hintText: 'Total Discounts',
                                      sufixLabel:
                                          '${data.totalDiscount.toString()}',
                                      prefixIcon: 'assets/icons/icon-offer.svg',
                                    ),
                                    SizedBox(height: 20.h),
                                    /* Row(
                                      children: [
                                        Expanded(
                                          child: Button(
                                            onTap: () {},
                                            textColor: AppColor.whiteColor,
                                            buttonText: 'Stock Checking',
                                            color: AppColor.blueColor,
                                            textStyle: AppTextStyles.smallBold
                                                .copyWith(fontSize: 11),
                                          ),
                                        ),
                                        Expanded(
                                          child: Button(
                                            buttonText: 'Search Customer',
                                            color: AppColor.greenColor,
                                            textStyle: AppTextStyles.smallBold
                                                .copyWith(fontSize: 11),
                                            onTap: () {
                                              Navigator.of(myContext!)
                                                  .pushNamed(
                                                      SearchCustomerScreen.id);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),*/
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 100.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Recent Sale Invoices",
                                            style: AppTextStyles.mediumBold
                                                .copyWith(
                                                    color: AppColor.blackColor),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ViewAllInvoiceScreen(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "View all",
                                              style: AppTextStyles.mediumBold
                                                  .copyWith(
                                                      color:
                                                          AppColor.blueColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    StreamBuilder(
                                        stream: resentSalesInvoicesStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    List<ModelInvoiceMerchant>>
                                                snapshot) {
                                          if (snapshot.data != null) {
                                            var list = snapshot.data!;
                                            return ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: list.length,
                                              itemBuilder: (context, index) =>
                                                  getRowSalesInvoice(
                                                      invoiceMerchant:
                                                          list[index]),
                                            );
                                          } else if (snapshot.error != null) {
                                            return Center(
                                                child: Text(
                                              snapshot.error.toString(),
                                              style: AppTextStyles.medium
                                                  .copyWith(
                                                      color:
                                                          AppColor.blackColor),
                                            ));
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.error != null) {
                  return Center(
                      child: Text(
                    snapshot.error.toString(),
                    style: AppTextStyles.medium
                        .copyWith(color: AppColor.blackColor),
                  ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  getRowSalesInvoice({required ModelInvoiceMerchant invoiceMerchant}) {
    return GestureDetector(
      onTap: () {
        view.getSaleInvoice(
            invoiceId: invoiceMerchant.invoiceId.toString(),
            completion: (InvoiceSaleModel? model) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SaleInvoiceScreen.invoice(
                    invoiceModel: model,
                  ),
                ),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.greyColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoiceMerchant.invoiceNumber.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    Text(
                      invoiceMerchant.client_name ?? "-",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.mediumBold
                          .copyWith(color: AppColor.blackColor, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoiceMerchant.invoiceDate.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    Text(
                      formatAmount(invoiceMerchant.invoiceAmount.toString()),
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.mediumBold
                          .copyWith(color: AppColor.blackColor, fontSize: 17),
                    ),
                  ],
                ),
              ),
              /*      Text(
                oCcy.format(
                    double.parse(invoiceMerchant.invoiceAmount ?? "0.0")),
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor, fontSize: 16),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
