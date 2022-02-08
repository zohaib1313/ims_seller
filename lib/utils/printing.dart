import 'package:flutter/material.dart';
import 'package:ims_seller/models/mode_printer_product.dart';
import 'package:ims_seller/styles.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MyPrinting {
  _hSpaceSmall() => pw.SizedBox(width: 10);

  _vSpaceSmall() => pw.SizedBox(height: 5);

  _divider() => pw.Divider();

  Future<bool> doPrint(
      {required String title,
      required String address,
      required stringPhoneNo,
      required String invoiceNumber,
      required String dateTime,
      required String salePersonName,
      required String customerName,
      required String paymentMethod,
      required String totalAmount,
      required String discount,
      required List<ModelPrinterProduct> listOfProducts,
      required String numberOfItems,
      required String logoNetwork}) async {
    /* final logo = await flutterImageProvider(
        const AssetImage('assets/icons/printing_logo.png'))*/
    pw.ImageProvider? logo;
    printWrapped(logoNetwork);

    if (logoNetwork != "") {
      logo = await flutterImageProvider(NetworkImage(logoNetwork));
    } else {
      logo = null;
    }
    final doc = pw.Document(verbose: true);
    PrintingInfo res = await Printing.info();
    return Printing.layoutPdf(
      //format: PdfPageFormat.roll57,
      onLayout: (PdfPageFormat format) async {
        printWrapped(format.toString());
        /*doc.addPage(pw.Page(
            pageFormat: format,
            build: (pw.Context context) {
              return pw.ListView(children: [
                getHeader(logo, name, stringPhoneNo, address, invoiceNumber,
                    dateTime, salePersonName, customer, paymentMethod),
                pw.Column(
                  children: getAllProductsRow(listOfProducts),
                ),
                getFooter(numberOfItems, totalAmount, discount)
              ]); // Center
            }));*/

        doc.addPage(pw.MultiPage(
            pageFormat: format.copyWith(marginBottom: 0, marginTop: 0),
            margin: const pw.EdgeInsets.only(
                left: 5, right: 5, bottom: 0.0, top: 0.0),
            build: (context) {
              return [
                _getHeader(logo, title, stringPhoneNo, address, invoiceNumber,
                    dateTime, salePersonName, customerName, paymentMethod),
                pw.Column(
                  children: getAllProductsRow(listOfProducts),
                ),
                _getFooter(numberOfItems, totalAmount, discount)
              ];
            }));

        /*   for (pw.Widget p in printPages) {
          doc.addPage(pw.Page(
              pageFormat: format,
              build: (pw.Context context) {
                return p; // Center
              }));
        }*/

        return doc.save();
      },
    );
  }

  _getProductPwRow(
      {required String descrition,
      required String qty,
      required bool isBold,
      required String rate,
      required String amount}) {
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                flex: 3,
                child: pw.Text(descrition,
                    style: isBold
                        ? AppTextStyles.smallBoldPrint
                        : AppTextStyles.smallNormalPrint),
              ),
              _hSpaceSmall(),
              pw.Expanded(
                  child: pw.Text(qty,
                      textAlign: pw.TextAlign.center,
                      style: isBold
                          ? AppTextStyles.smallBoldPrint
                          : AppTextStyles.smallNormalPrint)),
              _hSpaceSmall(),
              pw.Expanded(
                  flex: 2,
                  child: pw.Text(rate,
                      textAlign: pw.TextAlign.center,
                      style: isBold
                          ? AppTextStyles.smallBoldPrint
                          : AppTextStyles.smallNormalPrint)),
              _hSpaceSmall(),
              pw.Expanded(
                  flex: 2,
                  child: pw.Text(amount,
                      textAlign: pw.TextAlign.center,
                      style: isBold
                          ? AppTextStyles.smallBoldPrint
                          : AppTextStyles.smallNormalPrint)),
            ],
          ),
          _vSpaceSmall(),
          _divider(),
          _vSpaceSmall(),
        ]);
  }

  List<pw.Widget> getAllProductsRow(List<ModelPrinterProduct> listOfProducts) {
    List<pw.Widget> xx = [];

    xx.add(_vSpaceSmall());
    xx.add(_vSpaceSmall());
    xx.add(_vSpaceSmall());
    xx.add(_vSpaceSmall());

    xx.add(_getProductPwRow(
        isBold: true,
        descrition: "Item Description",
        qty: "QTY",
        rate: "Rate",
        amount: "Amount"));
    for (var value in listOfProducts) {
      xx.add(_getProductPwRow(
          isBold: false,
          descrition: value.itemDescription ?? "",
          qty: value.itemQty ?? "",
          rate: value.itemRate ?? '',
          amount: value.itemAmount ?? ''));
    }
    return xx;
  }

  _getHeader(
      pw.ImageProvider? logo,
      String name,
      String stringPhoneNo,
      String address,
      String invoiceNumber,
      String dateTime,
      String salePersonName,
      String customer,
      String paymentMethod) {
    return pw.Container(
      // padding: pw.EdgeInsets.all(10),
      child: pw.Center(
        child: pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            // mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              logo != null
                  ? pw.Image(
                      logo,
                      height: 160,
                    )
                  : pw.Container(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              pw.Text(name,
                  style: AppTextStyles.mediumBoldPrint,
                  textAlign: pw.TextAlign.center),
              _vSpaceSmall(),
              pw.Text(address,
                  style: AppTextStyles.mediumNormalPrint,
                  textAlign: pw.TextAlign.center),
              _vSpaceSmall(),
              pw.Text(stringPhoneNo,
                  style: AppTextStyles.mediumNormalPrint,
                  textAlign: pw.TextAlign.center),
              _vSpaceSmall(),
              _divider(),
              pw.Text("Invoice# $invoiceNumber",
                  style: AppTextStyles.mediumBoldPrint,
                  textAlign: pw.TextAlign.center),
              _vSpaceSmall(),
              pw.Text(dateTime,
                  style: AppTextStyles.mediumNormalPrint,
                  textAlign: pw.TextAlign.center),
              _vSpaceSmall(),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text("Sale Person: ",
                        style: AppTextStyles.mediumBoldPrint,
                        textAlign: pw.TextAlign.center),
                    pw.Text(salePersonName,
                        style: AppTextStyles.smallBoldPrint,
                        textAlign: pw.TextAlign.center),
                  ]),
              _vSpaceSmall(),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Flexible(
                        child: pw.Text("Customer:",
                            style: AppTextStyles.mediumBoldPrint,
                            textAlign: pw.TextAlign.center)),
                    pw.Flexible(
                        child: pw.Text(customer,
                            style: AppTextStyles.smallNormalPrint,
                            textAlign: pw.TextAlign.center)),
                  ]),
              _vSpaceSmall(),
              pw.Text("Payment Method",
                  style: AppTextStyles.mediumBoldPrint,
                  textAlign: pw.TextAlign.center),
              _vSpaceSmall(),
              pw.Text(paymentMethod,
                  style: AppTextStyles.smallNormalPrint,
                  textAlign: pw.TextAlign.center),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
            ]),
      ),
    );
  }

  _getFooter(String numberOfItems, String totalAmount, String discount) {
    return pw.Container(
      child: pw.Center(
        child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Expanded(
                      child: pw.Text("Number of Items",
                          textAlign: pw.TextAlign.right,
                          style: AppTextStyles.smallNormalPrint),
                    ),
                    pw.Expanded(
                      child: pw.Text(numberOfItems,
                          textAlign: pw.TextAlign.right,
                          style: AppTextStyles.smallNormalPrint),
                    ),
                    _hSpaceSmall(),
                    _hSpaceSmall()
                  ]),
              _vSpaceSmall(),
              _vSpaceSmall(),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Expanded(
                      child: pw.Text("Total Amount",
                          textAlign: pw.TextAlign.right,
                          style: AppTextStyles.smallNormalPrint),
                    ),
                    pw.Expanded(
                      child: pw.Text(totalAmount,
                          textAlign: pw.TextAlign.right,
                          style: AppTextStyles.smallNormalPrint),
                    ),
                    _hSpaceSmall(),
                    _hSpaceSmall()
                  ]),
              _vSpaceSmall(),
              _vSpaceSmall(),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Expanded(
                      child: pw.Text("Discount",
                          textAlign: pw.TextAlign.right,
                          style: AppTextStyles.smallNormalPrint),
                    ),
                    pw.Expanded(
                      child: pw.Text(discount,
                          textAlign: pw.TextAlign.right,
                          style: AppTextStyles.smallNormalPrint),
                    ),
                    _hSpaceSmall(),
                    _hSpaceSmall()
                  ]),
              _divider(),
              _hSpaceSmall(),
              _hSpaceSmall(),
              pw.Text("Total Amount",
                  textAlign: pw.TextAlign.right,
                  style: AppTextStyles.smallNormalPrint),
              _hSpaceSmall(),
              _hSpaceSmall(),
              pw.Text(totalAmount,
                  textAlign: pw.TextAlign.right,
                  style: AppTextStyles.mediumBoldPrint),
              _hSpaceSmall(),
              _hSpaceSmall(),
              _divider(),
              _hSpaceSmall(),
              _hSpaceSmall(),
              _hSpaceSmall(),
              _hSpaceSmall(),
              pw.Text("*************************************",
                  textAlign: pw.TextAlign.center,
                  style: AppTextStyles.smallBoldPrint),
              _hSpaceSmall(),
              _hSpaceSmall(),
              pw.Text("Goods sold are not returnable or refundable",
                  textAlign: pw.TextAlign.center,
                  style: AppTextStyles.smallBoldPrint),
              _hSpaceSmall(),
              _hSpaceSmall(),
              pw.Text("*************************************",
                  textAlign: pw.TextAlign.center,
                  style: AppTextStyles.smallBoldPrint),
              _hSpaceSmall(),
              _hSpaceSmall(),
              pw.Text("Thank you for purchasing",
                  textAlign: pw.TextAlign.center,
                  style: AppTextStyles.smallBoldPrint),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              _vSpaceSmall(),
              pw.Container(),
              _vSpaceSmall(),
              _vSpaceSmall(),
            ]),
      ),
    );
  }
}
