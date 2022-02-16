import 'package:ims_seller/dio_network/decodable.dart';

class CustomerModel implements Decodable {
  int? id;
  String? name;
  String? phone;
  String? email;

  String? city;
  String? address;

  CustomerModel(
      {this.id, this.name, this.phone, this.email, this.city, this.address});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];

    city = json['city'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;

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
    city = json['city'];
    address = json['address'];
    return this;
  }

  @override
  String toString() {
    return 'CustomerModel{id: $id, name: $name, phone: $phone, email: $email, city: $city, address: $address}';
  }
}
