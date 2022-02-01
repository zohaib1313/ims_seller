import 'package:ims_seller/dio_network/decodable.dart';

class ModelMethodsList implements Decodable {
  List<ModelMethods> modelMethodList = [];

  @override
  decode(json) {
    modelMethodList =
        List<ModelMethods>.from(json.map((x) => ModelMethods.fromJson(x)));
    return this;
  }

  @override
  String toString() {
    return 'modelMethodList{modelMethodList: $modelMethodList}';
  }
}

class ModelMethods {
  String? name;
  String? id;
  bool? active;

  ModelMethods({this.name, this.id, this.active});

  ModelMethods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['active'] = this.active;
    return data;
  }

  @override
  String toString() {
    return 'ModelPaymentMethods{name: $name, id: $id, active: $active}';
  }
}
