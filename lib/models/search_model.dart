import 'package:shop/models/products_model.dart';

class SearchModel {
  late bool status;
  late String message;
  late dynamic data;
  List<ProductModel> products = [];
  late int currentPage;
  late String firstPageUrl;
  late int? from;
  late int lastPage;
  late String lastPageUrl;
  late String nextPageUrl;
  late String path;
  late int perPage;
  late String prevPageUrl;
  late int? to;
  late int total;

  SearchModel.fromJson(Map<String, dynamic> json, {required List<ProductModel> productsList}) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'];

    if (data != null) {
      for (var elementData in data['data']) {
        final product = productsList.where((element) => element.id == elementData['id']).first;
        products.add(product);
      }

      currentPage = data['current_page'];
      firstPageUrl = data['first_page_url'].toString();
      from = data['from'];
      lastPage = data['last_page'];
      lastPageUrl = data['last_page_url'].toString();
      nextPageUrl = data['next_page_url'].toString();
      path = data['path'].toString();
      perPage = data['per_page'];
      prevPageUrl = data['prev_page_url'].toString();
      to = data['to'];
      total = data['total'];
    }
  }
}
