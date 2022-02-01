import 'package:ims_seller/dio_network/decodable.dart';

class ProductDetailScannedModel implements Decodable {
  String? imeiNumber;
  String? branchId;
  int _localQty = 1;
  ProductDetail? productDetail;

  ProductDetailScannedModel(
      {this.imeiNumber, this.branchId, this.productDetail});

  ProductDetailScannedModel.fromJson(Map<String, dynamic> json) {
    imeiNumber = json['imei_number'];
    branchId = json['branch_id'];
    productDetail = json['product_detail'] != null
        ? new ProductDetail.fromJson(json['product_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei_number'] = this.imeiNumber;
    data['branch_id'] = this.branchId;
    if (this.productDetail != null) {
      data['product_detail'] = this.productDetail!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    imeiNumber = json['imei_number'];
    branchId = json['branch_id'];
    productDetail = json['product_detail'] != null
        ? ProductDetail.fromJson(json['product_detail'])
        : null;
    return this;
  }

  int get localQty => _localQty;

  set localQty(int value) {
    _localQty = value;
  }
}

class ProductDetail {
  int? id;
  int? iProductSubCategoryId;
  int? iProductTypeId;
  String? logo;
  String? shortCode;
  String? name;
  String? modelCode;
  String? purchasePrice;
  String? salePrice;
  bool? haveDiffBarcode;
  bool? ownershipRegistration;
  String? iProductSubCategoryName;
  int? availableProductQuantityInBranch;
  String? retailPrice;
  String? wholesalePrice;

  ProductDetail(
      {this.id,
      this.iProductSubCategoryId,
      this.iProductTypeId,
      this.logo,
      this.shortCode,
      this.name,
      this.modelCode,
      this.purchasePrice,
      this.salePrice,
      this.haveDiffBarcode,
      this.ownershipRegistration,
      this.iProductSubCategoryName,
      this.availableProductQuantityInBranch,
      this.retailPrice,
      this.wholesalePrice});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iProductSubCategoryId = json['i_product_sub_category_id'];
    iProductTypeId = json['i_product_type_id'];
    logo = json['logo'];
    shortCode = json['short_code'];
    name = json['name'];
    modelCode = json['model_code'];
    purchasePrice = json['purchase_price'];
    salePrice = json['sale_price'];
    haveDiffBarcode = json['have_diff_barcode'];
    ownershipRegistration = json['ownership_registration'];
    iProductSubCategoryName = json['i_product_sub_category_name'];
    availableProductQuantityInBranch =
        json['available_product_quantity_in_branch'];
    retailPrice = json['retail_price'];
    wholesalePrice = json['wholesale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['i_product_sub_category_id'] = this.iProductSubCategoryId;
    data['i_product_type_id'] = this.iProductTypeId;
    data['logo'] = this.logo;
    data['short_code'] = this.shortCode;
    data['name'] = this.name;
    data['model_code'] = this.modelCode;
    data['purchase_price'] = this.purchasePrice;
    data['sale_price'] = this.salePrice;
    data['have_diff_barcode'] = this.haveDiffBarcode;
    data['ownership_registration'] = this.ownershipRegistration;
    data['i_product_sub_category_name'] = this.iProductSubCategoryName;
    data['available_product_quantity_in_branch'] =
        this.availableProductQuantityInBranch;
    data['retail_price'] = this.retailPrice;
    data['wholesale_price'] = this.wholesalePrice;
    return data;
  }
}
