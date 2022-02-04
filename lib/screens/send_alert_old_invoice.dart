import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/invoice_sale_model.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/styles.dart';

class SendAlertInvoiceOldSaleInvoiceScreen extends StatefulWidget {
  InvoiceSaleModel? invoiceModel;

  SendAlertInvoiceOldSaleInvoiceScreen(this.invoiceModel);

  @override
  State<SendAlertInvoiceOldSaleInvoiceScreen> createState() =>
      _SendAlertInvoiceOldSaleInvoiceScreenState();
}

class _SendAlertInvoiceOldSaleInvoiceScreenState
    extends State<SendAlertInvoiceOldSaleInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(120.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(),
              SizedBox(height: 30.h),
              Text(
                "Invoice# ${widget.invoiceModel?.saleInvoice![0].invoiceNumber ?? ""}",
                style: AppTextStyles.largeBold
                    .copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.blueColor),
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Customer Name:",
                            style: AppTextStyles.smallBold
                                .copyWith(color: AppColor.whiteColor),
                          ),
                          Text(
                            widget.invoiceModel?.saleInvoice![0].iClient
                                    ?.tradingName ??
                                "",
                            style: AppTextStyles.smallBold
                                .copyWith(color: AppColor.whiteColor),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "",
                          style: AppTextStyles.smallBold
                              .copyWith(color: AppColor.blackColor),
                        ),
                        Text(
                          widget.invoiceModel?.saleInvoice![0].iClient
                                  ?.pocPhone ??
                              "",
                          style: AppTextStyles.smallBold
                              .copyWith(color: AppColor.whiteColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "Notification method:",
                style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Button(
                    onTap: () {},
                    width: 800.w,
                    color: AppColor.greenColor,
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
            svgPath: 'assets/icons/icon-arrow-back.svg',
            height: 25,
            width: 25,
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

  getPaymentMethodIcName(InvoiceSaleModel? invoiceModel) {
    switch (invoiceModel!.paymentMethod!) {
      case 'cs':
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Flexible(
              child: SvgViewer(
                svgPath: 'assets/icons/icon-cash.svg',
                width: 20,
                height: 20,
              ),
            ),
            SizedBox(width: 50.w),
            Flexible(
              child: Text(
                'Cash',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
            )
          ],
        );
      case 'cc':
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Flexible(
              child: SvgViewer(
                svgPath: 'assets/icons/icon-credit-card.svg',
                width: 20,
                height: 20,
              ),
            ),
            SizedBox(width: 50.w),
            Flexible(
              child: Text(
                'Credit Card',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
            )
          ],
        );
      case 'bt':
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Flexible(
              child: SvgViewer(
                svgPath: 'assets/icons/icon-bank.svg',
                width: 20,
                height: 20,
              ),
            ),
            SizedBox(width: 50.w),
            Flexible(
              child: Text(
                'Bank Transfer',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
            )
          ],
        );
    }
  }

  getSingleProduct(SubSaleInvoice saleInvoice) {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.greyColor),
          color: AppColor.whiteColor),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                saleInvoice.iProductItem!.iProduct!.shortCode.toString(),
                style: AppTextStyles.small.copyWith(color: AppColor.blackColor),
              )
            ],
          ),
          Row(
            children: [
              Text(
                saleInvoice.iProductItem!.iProduct!.name.toString(),
                style: AppTextStyles.small.copyWith(color: AppColor.blackColor),
              )
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                saleInvoice.qty! > 1
                    ? '${saleInvoice.price!} x ${saleInvoice.qty!}'
                    : "${saleInvoice.price!}",
                style: AppTextStyles.smallBold
                    .copyWith(color: AppColor.blackColor),
              ),
              Text(
                'MMK: ${saleInvoice.price!}',
                style: AppTextStyles.smallBold
                    .copyWith(color: AppColor.blackColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
