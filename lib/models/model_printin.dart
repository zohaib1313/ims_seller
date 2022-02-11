import 'mode_printer_product.dart';

class ModelPrintingFull {
  int? invoiceId;
  String? invoiceNumber;
  String? salePersonName;
  String? customerName;
  String customerPhone;
  String? address;
  String? title;
  String? branchPhoneNo;
  String? paymentMethod;
  bool? haveMail;
  String? logo;
  String? totalAmount;
  String? discount;
  String dateTime;
  List<ModelPrinterProduct> listOfProducts;

  ModelPrintingFull(
      {this.invoiceId,
      this.invoiceNumber,
      this.salePersonName,
      this.customerName,
      required this.customerPhone,
      this.address,
      this.title,
      this.branchPhoneNo,
      this.paymentMethod,
      this.haveMail,
      this.logo,
      this.totalAmount,
      this.discount,
      required this.dateTime,
      required this.listOfProducts});
}
