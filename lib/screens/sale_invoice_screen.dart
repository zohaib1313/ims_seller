import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/invoice_sale_model.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/styles.dart';

class SaleInvoiceScreen extends StatefulWidget {
  static const id = "newInvoiceScreen";
  InvoiceSaleModel? invoiceModel;

  SaleInvoiceScreen();

  SaleInvoiceScreen.invoice({Key? key, required this.invoiceModel})
      : super(key: key);

  @override
  _SaleInvoiceScreenState createState() => _SaleInvoiceScreenState();
}

class _SaleInvoiceScreenState extends State<SaleInvoiceScreen> {
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
                "Product List",
                style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.invoiceModel!.saleInvoice![0]
                              .saleInvoice!.length,
                          itemBuilder: (context, index) {
                            return getSingleProduct(widget.invoiceModel!
                                .saleInvoice![0].saleInvoice![index]);
                          }),
                      SizedBox(height: 30.h),
                      const Divider(color: AppColor.blackColor),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                'Payment Method:',
                                style: AppTextStyles.smallBold
                                    .copyWith(color: AppColor.blackColor),
                              )),
                          Spacer(),
                          Expanded(
                            flex: 3,
                            child: getPaymentMethodIcName(widget.invoiceModel),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      const Divider(color: AppColor.blackColor),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                'Total Amount',
                                style: AppTextStyles.medium
                                    .copyWith(color: AppColor.blackColor),
                              )),
                          Spacer(),
                          Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      (double.parse(widget
                                                  .invoiceModel!.discount!) +
                                              double.parse(
                                                  widget.invoiceModel!.amount!))
                                          .toString(),
                                      style: AppTextStyles.medium
                                          .copyWith(color: AppColor.blackColor),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      SizedBox(height: 20.h),
                      const Divider(color: AppColor.blackColor),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                'Discount',
                                style: AppTextStyles.medium
                                    .copyWith(color: AppColor.blackColor),
                              )),
                          Spacer(),
                          Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.invoiceModel!.discount!.toString(),
                                      style: AppTextStyles.medium
                                          .copyWith(color: AppColor.blackColor),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      SizedBox(height: 20.h),
                      const Divider(color: AppColor.blackColor),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                'Grand Total',
                                style: AppTextStyles.medium
                                    .copyWith(color: AppColor.blackColor),
                              )),
                          Spacer(),
                          Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.invoiceModel!.amount!,
                                      style: AppTextStyles.largeBold
                                          .copyWith(color: AppColor.blackColor),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      SizedBox(height: 20.h),
                      const Divider(color: AppColor.blackColor),
                      SizedBox(height: 20.h),
                    ],
                  ),
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
                    buttonText: 'Options',
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
              style:
                  AppTextStyles.smallBold.copyWith(color: AppColor.blackColor),
            ),
            Text(
              'MMK: ${saleInvoice.price!}',
              style:
                  AppTextStyles.smallBold.copyWith(color: AppColor.blackColor),
            )
          ],
        ),
      ],
    ),
  );
}
