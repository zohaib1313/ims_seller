import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/model_printin.dart';
import 'package:ims_seller/utils/printing.dart';

import '../styles.dart';
import 'main_screen.dart';

class SuccessScreen extends StatefulWidget {
  static const id = 'SuccessScreen';
  String title;
  bool printt;
  ModelPrintingFull? modelPrintingFull;

  SuccessScreen(
      {Key? key,
      required this.title,
      required this.printt,
      required this.modelPrintingFull})
      : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          SvgViewer(
            svgPath: 'assets/icons/icon-check.svg',
            color: AppColor.greenColor,
            height: 550.r,
            width: 550.r,
          ),
          SizedBox(height: 10.h),
          Text(
            widget.title,
            style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
          ),
          SizedBox(height: 10.h),
          SizedBox(height: 10.h),
          Visibility(
            visible: widget.printt,
            child: InkWell(
              onTap: () async {
                if (widget.modelPrintingFull != null) {
                  int count = 0;
                  for (var item in widget.modelPrintingFull!.listOfProducts) {
                    count = count + (int.parse(item.itemQty ?? "1"));
                  }
                  bool result = await MyPrinting().doPrint(
                      title: widget.modelPrintingFull?.title ?? "",
                      logoNetwork: widget.modelPrintingFull?.logo ?? "",
                      address: widget.modelPrintingFull?.address ?? "",
                      stringPhoneNo:
                          widget.modelPrintingFull?.branchPhoneNo ?? "",
                      invoiceNumber:
                          widget.modelPrintingFull?.invoiceNumber ?? "",
                      dateTime:
                          widget.modelPrintingFull?.dateTime.toString() ?? "",
                      salePersonName:
                          widget.modelPrintingFull?.salePersonName ?? "-",
                      customerName:
                          widget.modelPrintingFull?.customerName ?? "",
                      paymentMethod:
                          widget.modelPrintingFull?.paymentMethod ?? "",
                      totalAmount:
                          widget.modelPrintingFull?.totalAmount ?? "0.0",
                      discount: widget.modelPrintingFull?.discount ?? "0.0",
                      listOfProducts: widget.modelPrintingFull!.listOfProducts,
                      numberOfItems: count.toString());
                  if (result) {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(MainScreen.id));
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Print",
                  style: AppTextStyles.mediumBold
                      .copyWith(color: AppColor.blackColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    )));
  }

  @override
  void initState() {
    super.initState();
    // Timer(
    //   const Duration(seconds: 3),
    //   () => {
    //     if (widget.printt)
    //       {
    //         Provider.of<AddNewProductViewModel>(myContext!, listen: false)
    //             .doPrint()
    //       },
    //   },
    // );
  }
}
