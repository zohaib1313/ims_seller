import 'package:ims_seller/dio_network/decodable.dart';

class AddNewCustomerModel implements Decodable {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? memberShip;
  String? city;
  String? address;

  AddNewCustomerModel(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.memberShip,
      this.city,
      this.address});

  AddNewCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    memberShip = json['member_ship'];
    city = json['city'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['member_ship'] = this.memberShip;
    data['city'] = this.city;
    data['address'] = this.address;
    return data;
  }

  @override
  decode(json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    memberShip = json['member_ship'];
    city = json['city'];
    address = json['address'];
    return this;
  }
}
