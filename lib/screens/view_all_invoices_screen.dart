import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/models/invoice_sale_model.dart';
import 'package:ims_seller/models/model_invoice_merchat.dart';
import 'package:ims_seller/screens/sale_invoice_screen.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:ims_seller/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../styles.dart';

class ViewAllInvoiceScreen extends StatefulWidget {
  ViewAllInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllInvoiceScreen> createState() => _ViewAllInvoiceScreenState();
}

class _ViewAllInvoiceScreenState extends State<ViewAllInvoiceScreen> {
  var view = Provider.of<DashboardViewModel>(myContext!);
  late ScrollController controller;
  Stream<bool>? isLoadingStream;

  @override
  void initState() {
    super.initState();
    isLoadingStream = view.getMerchantPaginatedInvoice();
    controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.position.extentAfter == 0) {
      printWrapped("At last item");
      if (!view.inProgress && view.haveMoreItem) {
        view.inProgress = true;
        isLoadingStream = view.getMerchantPaginatedInvoice();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        view.resetState();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    view.resetState();
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
                                .copyWith(color: AppColor.blackColor)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 100.w, top: 20.h, bottom: 10.h),
                  child: Text(
                    "Recent Sale Invoices",
                    style: AppTextStyles.mediumBold
                        .copyWith(color: AppColor.blackColor),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: isLoadingStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                            controller: controller,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: view.listOfInvoices.length,
                            itemBuilder: (context, index) => getRowSalesInvoice(
                                invoiceMerchant: view.listOfInvoices[index]),
                          );
                        } else if (snapshot.error != null) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: AppTextStyles.medium
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
              ],
            ),
          ),
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
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    Text(
                      invoiceMerchant.client_name ?? "-",
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
                        style: AppTextStyles.smallBold.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    Text(
                      formatAmount(invoiceMerchant.invoiceAmount.toString()),
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
