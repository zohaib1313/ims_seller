import 'package:ims_seller/dio_network/decodable.dart';

class ModelInvoiceMerchant {
  int? invoiceId;
  String? invoiceNumber;
  int? qty;
  String? price;
  String? invoiceDate;
  String? amount;
  String? invoiceAmount;
  String? paymentMethod;
  String? invoiceDiscount;
  String? invoiceTax;
  String? client_name;

  ModelInvoiceMerchant(
      {this.invoiceId,
      this.invoiceNumber,
      this.qty,
      this.price,
      this.client_name,
      this.invoiceDate,
      this.amount,
      this.invoiceAmount,
      this.paymentMethod,
      this.invoiceDiscount,
      this.invoiceTax});

  ModelInvoiceMerchant.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invoiceNumber = json['invoice_number'];
    qty = json['qty'];
    price = json['price'];
    client_name = json['client_name'];
    invoiceDate = json['invoice_date'];
    amount = json['amount'];
    invoiceAmount = json['invoice_amount'];
    paymentMethod = json['payment_method'];
    invoiceDiscount = json['invoice_discount'];
    invoiceTax = json['invoice_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['invoice_number'] = this.invoiceNumber;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['invoice_date'] = this.invoiceDate;
    data['amount'] = this.amount;
    data['client_name'] = this.client_name;
    data['invoice_amount'] = this.invoiceAmount;
    data['payment_method'] = this.paymentMethod;
    data['invoice_discount'] = this.invoiceDiscount;
    data['invoice_tax'] = this.invoiceTax;
    return data;
  }
}

class InvoicesMerchantModelList implements Decodable {
  List<ModelInvoiceMerchant> invoicesList = [];

  @override
  decode(json) {
    invoicesList = List<ModelInvoiceMerchant>.from(
        json.map((x) => ModelInvoiceMerchant.fromJson(x)));
    return this;
  }

  @override
  String toString() {
    return 'InvoicesMerchantModelList{searchResultList: $invoicesList}';
  }
}
