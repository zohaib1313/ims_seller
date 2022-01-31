import 'package:ims_seller/dio_network/decodable.dart';

class InvoiceSaleModel implements Decodable {
  int? id;
  String? invoiceDate;
  String? amount;
  String? discount;
  String? tax;
  String? paymentMethod;
  String? reference;
  String? invoiceDesc;
  String? internalDesc;
  IBranch? iBranch;
  List<SaleInvoice>? saleInvoice;
  String? bankTransferDetail;

  InvoiceSaleModel(
      {this.id,
      this.invoiceDate,
      this.amount,
      this.discount,
      this.tax,
      this.paymentMethod,
      this.reference,
      this.invoiceDesc,
      this.internalDesc,
      this.iBranch,
      this.saleInvoice,
      this.bankTransferDetail});

  InvoiceSaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceDate = json['invoice_date'];
    amount = json['amount'];
    discount = json['discount'];
    tax = json['tax'];
    paymentMethod = json['payment_method'];
    reference = json['reference'];
    invoiceDesc = json['invoice_desc'];
    internalDesc = json['internal_desc'];
    iBranch =
        json['i_branch'] != null ? IBranch.fromJson(json['i_branch']) : null;
    if (json['SaleInvoice'] != null) {
      saleInvoice = <SaleInvoice>[];
      json['SaleInvoice'].forEach((v) {
        saleInvoice!.add(SaleInvoice.fromJson(v));
      });
    }
    bankTransferDetail = json['bank_transfer_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_date'] = this.invoiceDate;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['payment_method'] = this.paymentMethod;
    data['reference'] = this.reference;
    data['invoice_desc'] = this.invoiceDesc;
    data['internal_desc'] = this.internalDesc;
    if (this.iBranch != null) {
      data['i_branch'] = this.iBranch!.toJson();
    }
    if (this.saleInvoice != null) {
      data['SaleInvoice'] = this.saleInvoice!.map((v) => v.toJson()).toList();
    }
    data['bank_transfer_detail'] = this.bankTransferDetail;
    return data;
  }

  @override
  decode(json) {
    id = json['id'];
    invoiceDate = json['invoice_date'];
    amount = json['amount'];
    discount = json['discount'];
    tax = json['tax'];
    paymentMethod = json['payment_method'];
    reference = json['reference'];
    invoiceDesc = json['invoice_desc'];
    internalDesc = json['internal_desc'];
    iBranch =
        json['i_branch'] != null ? IBranch.fromJson(json['i_branch']) : null;
    if (json['SaleInvoice'] != null) {
      saleInvoice = <SaleInvoice>[];
      json['SaleInvoice'].forEach((v) {
        saleInvoice!.add(SaleInvoice.fromJson(v));
      });
    }
    bankTransferDetail = json['bank_transfer_detail'];
    return this;
  }
}

class IBranch {
  int? id;
  String? name;
  String? logo;
  String? phone;
  String? email;
  String? city;
  String? address;
  String? openingBalance;
  bool? isHeadoffice;
  String? invoicePrefix;

  IBranch(
      {this.id,
      this.name,
      this.logo,
      this.phone,
      this.email,
      this.city,
      this.address,
      this.openingBalance,
      this.isHeadoffice,
      this.invoicePrefix});

  IBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    address = json['address'];
    openingBalance = json['opening_balance'];
    isHeadoffice = json['is_headoffice'];
    invoicePrefix = json['invoice_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['city'] = this.city;
    data['address'] = this.address;
    data['opening_balance'] = this.openingBalance;
    data['is_headoffice'] = this.isHeadoffice;
    data['invoice_prefix'] = this.invoicePrefix;
    return data;
  }
}

class SaleInvoice {
  int? id;
  int? iInvoiceId;
  String? invoiceNumber;
  IClient? iClient;
  List<SubSaleInvoice>? saleInvoice;
  // List<Null>? creditCardInvoice;

  SaleInvoice({
    this.id,
    this.iInvoiceId,
    this.invoiceNumber,
    this.iClient,
    this.saleInvoice,
    // this.creditCardInvoice
  });

  SaleInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iInvoiceId = json['i_invoice_id'];
    invoiceNumber = json['invoice_number'];
    iClient =
        json['i_client'] != null ? IClient.fromJson(json['i_client']) : null;
    if (json['SaleInvoice'] != null) {
      saleInvoice = <SubSaleInvoice>[];
      json['SaleInvoice'].forEach((v) {
        saleInvoice!.add(SubSaleInvoice.fromJson(v));
      });
    }
    if (json['credit_card_invoice'] != null) {
      // creditCardInvoice = <Null>[];
      // json['credit_card_invoice'].forEach((v) {
      //   creditCardInvoice!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['i_invoice_id'] = this.iInvoiceId;
    data['invoice_number'] = this.invoiceNumber;
    if (this.iClient != null) {
      data['i_client'] = this.iClient!.toJson();
    }
    if (this.saleInvoice != null) {
      data['SaleInvoice'] = this.saleInvoice!.map((v) => v.toJson()).toList();
    }
    // if (this.creditCardInvoice != null) {
    //   data['credit_card_invoice'] =
    //       this.creditCardInvoice!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class IClient {
  int? id;
  String? tradingName;
  String? pocEmail;
  String? pocPhone;
  bool? isActive;
  IMerchant? iMerchant;

  IClient(
      {this.id,
      this.tradingName,
      this.pocEmail,
      this.pocPhone,
      this.isActive,
      this.iMerchant});

  IClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tradingName = json['trading_name'];
    pocEmail = json['poc_email'];
    pocPhone = json['poc_phone'];
    isActive = json['is_active'];
    iMerchant = json['i_merchant'] != null
        ? new IMerchant.fromJson(json['i_merchant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['trading_name'] = this.tradingName;
    data['poc_email'] = this.pocEmail;
    data['poc_phone'] = this.pocPhone;
    data['is_active'] = this.isActive;
    if (this.iMerchant != null) {
      data['i_merchant'] = this.iMerchant!.toJson();
    }
    return data;
  }
}

class IMerchant {
  int? id;
  String? name;
  String? shortCode;
  String? phone;
  String? email;
  String? city;
  String? address;
  // Null? memberShip;
  bool? isClient;
  bool? isVendor;
  bool? isRetail;
  // Null? group;

  IMerchant({
    this.id,
    this.name,
    this.shortCode,
    this.phone,
    this.email,
    this.city,
    this.address,
    // this.memberShip,
    this.isClient,
    this.isVendor,
    this.isRetail,
    // this.group
  });

  IMerchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortCode = json['short_code'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    address = json['address'];
    // memberShip = json['member_ship'];
    isClient = json['is_client'];
    isVendor = json['is_vendor'];
    isRetail = json['is_retail'];
    // group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_code'] = this.shortCode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['city'] = this.city;
    data['address'] = this.address;
    //data['member_ship'] = this.memberShip;
    data['is_client'] = this.isClient;
    data['is_vendor'] = this.isVendor;
    data['is_retail'] = this.isRetail;
    // data['group'] = this.group;
    return data;
  }
}

class SubSaleInvoice {
  int? id;
  IProductItem? iProductItem;
  int? iInvoiceId;
  String? price;
  int? qty;

  SubSaleInvoice(
      {this.id, this.iProductItem, this.iInvoiceId, this.price, this.qty});

  SubSaleInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iProductItem = json['i_product_item'] != null
        ? new IProductItem.fromJson(json['i_product_item'])
        : null;
    iInvoiceId = json['i_invoice_id'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.iProductItem != null) {
      data['i_product_item'] = this.iProductItem!.toJson();
    }
    data['i_invoice_id'] = this.iInvoiceId;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}

class IProductItem {
  int? id;
  String? uid;
  bool? isPi;
  IProduct? iProduct;

  IProductItem({this.id, this.uid, this.isPi, this.iProduct});

  IProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    isPi = json['is_pi'];
    iProduct = json['i_product'] != null
        ? new IProduct.fromJson(json['i_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['is_pi'] = this.isPi;
    if (this.iProduct != null) {
      data['i_product'] = this.iProduct!.toJson();
    }
    return data;
  }
}

class IProduct {
  int? id;
  Null? logo;
  String? shortCode;
  String? name;
  String? modelCode;
  String? purchasePrice;
  String? salePrice;
  bool? haveDiffBarcode;
  bool? ownershipRegistration;
  IProductSubCategory? iProductSubCategory;
  IProductCategory? iProductType;

  IProduct(
      {this.id,
      this.logo,
      this.shortCode,
      this.name,
      this.modelCode,
      this.purchasePrice,
      this.salePrice,
      this.haveDiffBarcode,
      this.ownershipRegistration,
      this.iProductSubCategory,
      this.iProductType});

  IProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    shortCode = json['short_code'];
    name = json['name'];
    modelCode = json['model_code'];
    purchasePrice = json['purchase_price'];
    salePrice = json['sale_price'];
    haveDiffBarcode = json['have_diff_barcode'];
    ownershipRegistration = json['ownership_registration'];
    iProductSubCategory = json['i_product_sub_category'] != null
        ? new IProductSubCategory.fromJson(json['i_product_sub_category'])
        : null;
    iProductType = json['i_product_type'] != null
        ? new IProductCategory.fromJson(json['i_product_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['short_code'] = this.shortCode;
    data['name'] = this.name;
    data['model_code'] = this.modelCode;
    data['purchase_price'] = this.purchasePrice;
    data['sale_price'] = this.salePrice;
    data['have_diff_barcode'] = this.haveDiffBarcode;
    data['ownership_registration'] = this.ownershipRegistration;
    if (this.iProductSubCategory != null) {
      data['i_product_sub_category'] = this.iProductSubCategory!.toJson();
    }
    if (this.iProductType != null) {
      data['i_product_type'] = this.iProductType!.toJson();
    }
    return data;
  }
}

class IProductSubCategory {
  int? id;
  String? shortCode;
  String? name;
  IProductCategory? iProductCategory;

  IProductSubCategory(
      {this.id, this.shortCode, this.name, this.iProductCategory});

  IProductSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortCode = json['short_code'];
    name = json['name'];
    iProductCategory = json['i_product_category'] != null
        ? new IProductCategory.fromJson(json['i_product_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['short_code'] = this.shortCode;
    data['name'] = this.name;
    if (this.iProductCategory != null) {
      data['i_product_category'] = this.iProductCategory!.toJson();
    }
    return data;
  }
}

class IProductCategory {
  int? id;
  String? shortCode;
  String? name;

  IProductCategory({this.id, this.shortCode, this.name});

  IProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortCode = json['short_code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['short_code'] = this.shortCode;
    data['name'] = this.name;
    return data;
  }
}
