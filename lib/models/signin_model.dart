import 'package:ims_seller/dio_network/decodable.dart';

class SignInModel implements Decodable {
  String? token;
  int? userId;
  String? email;
  String? username;
  String? firstName;
  String? lastName;
  BranchDetail? branchDetail;

  SignInModel(
      {this.token,
      this.userId,
      this.email,
      this.username,
      this.firstName,
      this.lastName,
      this.branchDetail});

  SignInModel.fromJson(Map<dynamic, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    branchDetail = json['branch_detail'] != null
        ? BranchDetail.fromJson(json['branch_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.branchDetail != null) {
      data['branch_detail'] = this.branchDetail!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    token = json['token'];
    userId = json['user_id'];
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    branchDetail = json['branch_detail'] != null
        ? BranchDetail.fromJson(json['branch_detail'])
        : null;
    return this;
  }
}

class BranchDetail {
  int? id;
  String? name;
  String? logo;
  String? phone;
  String? email;
  String? city;
  String? address;

  BranchDetail(
      {this.id,
      this.name,
      this.logo,
      this.phone,
      this.email,
      this.city,
      this.address});

  BranchDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    phone = json['phone'];
    email = json['email'];
    city = json['city'];
    address = json['address'];
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
    return data;
  }
}
