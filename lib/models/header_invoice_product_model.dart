// "imei_number": "888462108416",
// "product_qty": "1"
// "product_price": "35000.00",
class HeaderInvoiceModelProduct {
  String? imei_number;
  String? product_qty;
  String? product_price;

  HeaderInvoiceModelProduct(
      {this.imei_number, this.product_qty, this.product_price});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['imei_number'] = this.imei_number!;
    data['product_qty'] = this.product_qty!;
    data['product_price'] = this.product_price!;

    return data;
  }
}
