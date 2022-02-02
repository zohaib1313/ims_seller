import 'package:ims_seller/dio_network/decodable.dart';

import 'add_new_customer_model.dart';

class SearchResultModelList implements Decodable {
  List<CustomerModel> searchResultList = [];

  @override
  decode(json) {
    searchResultList =
        List<CustomerModel>.from(json.map((x) => CustomerModel.fromJson(x)));
    return this;
  }

  @override
  String toString() {
    return 'SearchResultModelList{SearchResultModelList: $searchResultList}';
  }
}
