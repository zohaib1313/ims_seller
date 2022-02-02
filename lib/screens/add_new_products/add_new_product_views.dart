import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/model_payment_methods.dart';
import 'package:ims_seller/models/product_detail_scanned_model.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';

import '../../styles.dart';

scanProductView(view) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Scan Product",
        style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
      ),
      SizedBox(height: 20.h),
      const Center(
        child: SvgViewer(
          svgPath: 'assets/icons/scan_hand_ic.svg',
        ),
      ),
      SizedBox(height: 20.h),
    ],
  );
}

selectPaymentView(view) {
  view.getPaymentMethods();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Select Payment",
        style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
      ),
      SizedBox(height: 20.h),
      Center(
        child: StreamBuilder(
            stream: view.paymentListStream.stream,
            builder: (BuildContext context,
                AsyncSnapshot<List<ModelMethods>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                var list = snapshot.data!;
                List<Widget> listOfWidget = [];

                for (var element in list) {
                  listOfWidget.add(
                    getPaymentMethodItem(
                        view: view,
                        enabled: element.active ?? true,
                        title: element.name ?? "-",
                        icon: getIcon(element.id ?? "bt"),
                        paymentMethod: getType(element.id ?? "bt")),
                  );
                }
                return StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: listOfWidget,
                );
              } else {
                return const Center(
                  child: Text("No data found"),
                );
              }
            }),
      ),
      SizedBox(height: 20.h),
    ],
  );
}

getType(String id) {
  switch (id) {
    case 'cs':
      return PaymentMethod.cash;
    case 'cc':
      return PaymentMethod.creditCard;
    case 'bt':
      return PaymentMethod.bank;
  }
}

getIcon(String id) {
  switch (id) {
    case 'cs':
      return 'assets/icons/icon-cash.svg';
    case 'cc':
      return 'assets/icons/icon-credit-card.svg';
    case 'bt':
      return 'assets/icons/icon-bank.svg';
  }
}

getPaymentMethodItem(
    {required String title,
    required AddNewProductViewModel view,
    required String icon,
    required PaymentMethod paymentMethod,
    required bool enabled}) {
  return AbsorbPointer(
    absorbing: !enabled,
    child: GestureDetector(
      onTap: () {
        view.changePaymentMethod(paymentMethod);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: enabled ? AppColor.whiteColor : AppColor.alphaGrey,
            border: Border.all(
                color: !enabled
                    ? AppColor.alphaGrey
                    : (view.selectedPaymentMethod == paymentMethod
                        ? AppColor.blueColor
                        : AppColor.greyColor))),
        padding: EdgeInsets.all(20.r),
        margin: EdgeInsets.all(50.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: !enabled
                      ? AppColor.alphaGrey
                      : (view.selectedPaymentMethod == paymentMethod
                          ? AppColor.blueColor
                          : AppColor.whiteColor),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: AppColor.whiteColor,
                  ),
                  maxRadius: 10,
                )
              ],
            ),
            SvgViewer(
                svgPath: icon,
                color: view.selectedPaymentMethod == paymentMethod
                    ? AppColor.blueColor
                    : AppColor.blackColor),
            Text(
              title,
              style: AppTextStyles.mediumBold.copyWith(
                  color: view.selectedPaymentMethod == paymentMethod
                      ? AppColor.blueColor
                      : AppColor.blackColor),
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    ),
  );
}

bankPaymentDetails(view) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Bank Transfer",
        style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
      ),
      SizedBox(height: 20.h),
      Center(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              'Select Bank *',
              style:
                  AppTextStyles.mediumBold.copyWith(color: AppColor.blackColor),
            ),
            SizedBox(height: 10.h),
            MyDropDown(
                rightPadding: 0,
                leftPadding: 0,
                onChange: (value) {},
                borderColor: AppColor.blackColor,
                hintColor: AppColor.blackColor,
                labelColor: AppColor.blackColor,
                hintText: 'Select Bank',
                items: ['A', 'B'],
                validator: (string) {
                  if (string == null) {
                    return "select bank";
                  }
                }),
            SizedBox(height: 20.h),
            Text(
              'Transaction No. *',
              style:
                  AppTextStyles.mediumBold.copyWith(color: AppColor.blackColor),
            ),
            SizedBox(height: 10.h),
            MyTextField(
              leftPadding: 0,
              rightPadding: 0,
              hintText: '123456789',
            ),
            SizedBox(height: 20.h),
            /*   Text(
                'Upload Receipt ',
                style: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),
              SizedBox(height: 20.h),
              Button(
                onTap: () {},
                leftPadding: 0,
                rightPading: 0,
                padding: 10.h,
                color: AppColor.whiteColor,
                borderColor: AppColor.blackColor,
                buttonText: 'Upload',
                textStyle: AppTextStyles.mediumBold
                    .copyWith(color: AppColor.blackColor),
              ),*/
            SizedBox(height: 200.h),
          ],
        ),
      ),
      SizedBox(height: 20.h),
    ],
  );
}

productListView(view) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Product List",
        style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
      ),
      SizedBox(height: 20.h),
      Center(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: view.listOfScannedProducts.length,
          itemBuilder: (context, index) {
            if (view.listOfScannedProducts != null) {
              return getProductBaseOnType(
                  view.listOfScannedProducts[index]!, view);
            } else {
              return Container(color: Colors.red);
            }
          },
        ),
      ),
      SizedBox(height: 20.h),
    ],
  );
}

getProductBaseOnType(
    ProductDetailScannedModel product, AddNewProductViewModel view) {
  if (product.productDetail!.haveDiffBarcode!) {
    return Container(
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyColor),
          borderRadius: BorderRadius.circular(12),
          color: AppColor.whiteColor),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productDetail?.shortCode ?? "-",
                  style:
                      AppTextStyles.small.copyWith(color: AppColor.blackColor),
                ),
                Text(
                  product.productDetail?.name ?? "-",
                  style:
                      AppTextStyles.small.copyWith(color: AppColor.blackColor),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "",
                        style: AppTextStyles.mediumBold
                            .copyWith(color: AppColor.blackColor),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        product.productDetail?.retailPrice ?? "-",
                        style: AppTextStyles.mediumBold
                            .copyWith(color: AppColor.blackColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyColor),
          borderRadius: BorderRadius.circular(12),
          color: AppColor.whiteColor),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productDetail?.shortCode ?? "-",
                  style:
                      AppTextStyles.small.copyWith(color: AppColor.blackColor),
                ),
                Text(
                  product.productDetail?.name ?? "-",
                  style:
                      AppTextStyles.small.copyWith(color: AppColor.blackColor),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${product.productDetail?.salePrice ?? "-"} x ${product.localQty}",
                        style: AppTextStyles.medium
                            .copyWith(color: AppColor.blackColor),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "MMK: ${(double.parse(product.productDetail?.salePrice ?? "0") * product.localQty)}",
                          style: AppTextStyles.mediumBold.copyWith(
                              color: AppColor.blackColor, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    product.localQty = product.localQty + 1;
                    view.calculateTotalAmount();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: AppColor.blackColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: const Icon(
                      Icons.add,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: AppColor.alphaGrey,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Text(
                    product.localQty.toString(),
                    style: AppTextStyles.medium
                        .copyWith(color: AppColor.blackColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (product.localQty > 1) {
                      product.localQty = product.localQty - 1;
                      view.calculateTotalAmount();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: AppColor.blackColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: const Icon(
                      Icons.remove,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
