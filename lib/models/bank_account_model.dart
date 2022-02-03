import 'package:ims_seller/dio_network/decodable.dart';

class BankAccountModelList implements Decodable {
  List<BankAccountModel> bankAccountModelList = [];

  @override
  decode(json) {
    bankAccountModelList = List<BankAccountModel>.from(
        json.map((x) => BankAccountModel.fromJson(x)));
    return this;
  }

  @override
  String toString() {
    return 'BankAccountModelList{bankAccountModelList: $bankAccountModelList}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAccountModelList &&
          runtimeType == other.runtimeType &&
          bankAccountModelList == other.bankAccountModelList;

  @override
  int get hashCode => bankAccountModelList.hashCode;
}

class BankAccountModel {
  String? iBankShortCode;
  String? accName;
  String? accNumber;
  int? id;
  String? iBranchName;

  BankAccountModel(
      {this.iBankShortCode,
      this.accName,
      this.accNumber,
      this.id,
      this.iBranchName});

  BankAccountModel.fromJson(Map<String, dynamic> json) {
    iBankShortCode = json['i_bank__short_code'];
    accName = json['acc_name'];
    accNumber = json['acc_number'];
    id = json['id'];
    iBranchName = json['i_branch__name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_bank__short_code'] = this.iBankShortCode;
    data['acc_name'] = this.accName;
    data['acc_number'] = this.accNumber;
    data['id'] = this.id;
    data['i_branch__name'] = this.iBranchName;
    return data;
  }

  @override
  String toString() {
    return 'BankAccountModel{iBankShortCode: $iBankShortCode, accName: $accName, accNumber: $accNumber, id: $id, iBranchName: $iBranchName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAccountModel &&
          runtimeType == other.runtimeType &&
          iBankShortCode == other.iBankShortCode &&
          accName == other.accName &&
          accNumber == other.accNumber &&
          id == other.id &&
          iBranchName == other.iBranchName;

  @override
  int get hashCode =>
      iBankShortCode.hashCode ^
      accName.hashCode ^
      accNumber.hashCode ^
      id.hashCode ^
      iBranchName.hashCode;
}
