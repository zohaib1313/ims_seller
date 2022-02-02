import 'package:ims_seller/dio_network/decodable.dart';

class ModelSalesTarget implements Decodable {
  List<Targets>? targets;
  num? totalAchivement;
  num? totalSaleAmount;
  num? totalSaleQty;
  num? totalDiscount;
  num? totalSale;

  ModelSalesTarget(
      {this.targets,
      this.totalAchivement,
      this.totalSaleAmount,
      this.totalSaleQty,
      this.totalDiscount,
      this.totalSale});

  ModelSalesTarget.fromJson(Map<String, dynamic> json) {
    if (json['targets'] != null) {
      targets = <Targets>[];
      json['targets'].forEach((v) {
        targets!.add(new Targets.fromJson(v));
      });
    }
    totalAchivement = json['total_achivement'];
    totalSaleAmount = json['total_sale_amount'];
    totalSaleQty = json['total_sale_qty'];
    totalDiscount = json['total_discount'];
    totalSale = json['total_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.targets != null) {
      data['targets'] = this.targets!.map((v) => v.toJson()).toList();
    }
    data['total_achivement'] = this.totalAchivement;
    data['total_sale_amount'] = this.totalSaleAmount;
    data['total_sale_qty'] = this.totalSaleQty;
    data['total_discount'] = this.totalDiscount;
    data['total_sale'] = this.totalSale;
    return data;
  }

  @override
  decode(json) {
    if (json['targets'] != null) {
      targets = <Targets>[];
      json['targets'].forEach((v) {
        targets!.add(new Targets.fromJson(v));
      });
    }
    totalAchivement = json['total_achivement'];
    totalSaleAmount = json['total_sale_amount'];
    totalSaleQty = json['total_sale_qty'];
    totalDiscount = json['total_discount'];
    totalSale = json['total_sale'];
    return this;
  }
}

class Targets {
  String? name;
  num? targetAmount;
  num? achivedAmount;
  num? percentage;

  Targets({this.name, this.targetAmount, this.achivedAmount, this.percentage});

  Targets.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    targetAmount = json['target_amount'];
    achivedAmount = json['achived_amount'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['target_amount'] = this.targetAmount;
    data['achived_amount'] = this.achivedAmount;
    data['percentage'] = this.percentage;
    return data;
  }
}
