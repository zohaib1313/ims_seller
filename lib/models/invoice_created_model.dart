import 'package:ims_seller/dio_network/decodable.dart';

class InvoiceCreatedModel implements Decodable {
  int? invoiceId;
  String? invoiceNumber;

  InvoiceCreatedModel({this.invoiceId, this.invoiceNumber});

  InvoiceCreatedModel.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invoiceNumber = json['invoice_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['invoice_number'] = this.invoiceNumber;
    return data;
  }

  @override
  decode(json) {
    invoiceId = json['invoice_id'];
    invoiceNumber = json['invoice_number'];
    return this;
  }
}
