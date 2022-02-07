import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/bank_account_model.dart';
import 'package:ims_seller/models/model_payment_methods.dart';
import 'package:ims_seller/models/product_detail_scanned_model.dart';
import 'package:ims_seller/utils/utils.dart';
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

                return GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      var element = list[index];
                      return getPaymentMethodItem(
                          view: view,
                          enabled: element.active ?? true,
                          title: element.name ?? "-",
                          icon: getIcon(element.id ?? "bt"),
                          paymentMethod: getType(element.id ?? "bt"));
                    });
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
      return PaymentMethod.cs;
    case 'cc':
      return PaymentMethod.cc;
    case 'bt':
      return PaymentMethod.bt;
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
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: enabled ? AppColor.whiteColor : Colors.transparent,
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

bankPaymentDetails(AddNewProductViewModel view) {
  Stream<List<BankAccountModel>> bankAccountListStream =
      view.getBankAccountList();

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Bank Transfer",
        style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
      ),
      SizedBox(height: 20.h),
      StreamBuilder(
          stream: bankAccountListStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<BankAccountModel>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              var list = snapshot.data;
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      'Select Bank *',
                      style: AppTextStyles.mediumBold
                          .copyWith(color: AppColor.blackColor),
                    ),
                    SizedBox(height: 10.h),
                    MyDropDown(
                        rightPadding: 0,
                        leftPadding: 0,
                        onChange: (value) {
                          view.selectedBank = value;
                        },
                        borderColor: AppColor.blackColor,
                        hintColor: AppColor.blackColor,
                        labelColor: AppColor.blackColor,
                        hintText: 'Select Bank',
                        /*items: list
                            ?.map((e) =>
                                "${e.accName.toString()} | ${e.iBankShortCode.toString()}")
                            .toList(),*/
                        itemFuntion:
                            list?.map((BankAccountModel bankAccountModel) {
                          return DropdownMenuItem<BankAccountModel>(
                            value: bankAccountModel,
                            child: Text(
                              "${bankAccountModel.accName.toString()} | ${bankAccountModel.iBankShortCode.toString()}",
                              style: AppTextStyles.small
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          );
                        }).toList(),
                        validator: (string) {
                          if (string == null) {
                            return "select bank";
                          }
                        }),
                    SizedBox(height: 20.h),
                    Text(
                      'Transaction No. *',
                      style: AppTextStyles.mediumBold
                          .copyWith(color: AppColor.blackColor),
                    ),
                    SizedBox(height: 10.h),
                    MyTextField(
                      leftPadding: 0,
                      rightPadding: 0,
                      controller: view.selectedBankTransactionIdController,
                      hintText: 'xxxxxx',
                      validator: (string) {
                        if (string == null || string.isEmpty) {
                          return 'Enter Transaction no';
                        }
                        return null;
                      },
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
              );
            } else {
              return const Center(
                child: Text("No data found"),
              );
            }
          }),
      SizedBox(height: 20.h),
    ],
  );
}

productListView(AddNewProductViewModel view, bool showAdd) {
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
              return showAdd
                  ? Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        view.removeProductListItemAt(index);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).accentColor,
                            content: const Text(
                              'Deleted',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      confirmDismiss: (direction) {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text('Alert'),
                              content: const Text(
                                  'Are you sure you want to remove this item'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    // Navigator.pop(context, false);
                                    Navigator.of(
                                      context,
                                      // rootNavigator: true,
                                    ).pop(false);
                                  },
                                  child: const Text('No'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    // Navigator.pop(context, true);
                                    Navigator.of(
                                      context,
                                      // rootNavigator: true,
                                    ).pop(true);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      background: Container(
                        padding: const EdgeInsets.only(right: 20.0),
                        // alignment: AlignmentDirectional.centerEnd,
                        alignment: Alignment.centerRight,
                        color: AppColor.whiteColor,
                        child: const Icon(
                          Icons.delete,
                          size: 32.0,
                          color: AppColor.redColor,
                        ),
                      ),
                      child: getProductBaseOnType(
                          view.listOfScannedProducts[index]!, view, showAdd))
                  : getProductBaseOnType(
                      view.listOfScannedProducts[index]!, view, showAdd);
            } else {
              return const IgnorePointer();
            }
          },
        ),
      ),
      SizedBox(height: 20.h),
    ],
  );
}

getProductBaseOnType(ProductDetailScannedModel product,
    AddNewProductViewModel view, bool showAdd) {
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
                        "MMK: ${formatAmount(product.productDetail?.salePrice)}",
                        style: AppTextStyles.mediumBold
                            .copyWith(color: AppColor.blackColor, fontSize: 12),
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
                        "${formatAmount(product.productDetail?.salePrice)} x ${product.localQty}",
                        style: AppTextStyles.medium
                            .copyWith(color: AppColor.blackColor, fontSize: 12),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "MMK: ${formatAmount((double.parse(product.productDetail?.salePrice ?? "0") * product.localQty).toString())}",
                          style: AppTextStyles.mediumBold.copyWith(
                              color: AppColor.blackColor, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Visibility(
            visible: showAdd,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (product.localQty <
                          product.productDetail!
                              .availableProductQuantityInBranch!) {
                        product.localQty = product.localQty + 1;
                        view.calculateTotalAmount();
                      } else {
                        AppPopUps.showAlertDialog(
                            message: "Stock Limit reached");
                      }
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
            ),
          )
        ],
      ),
    );
  }
}
