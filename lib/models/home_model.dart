import 'package:shop/models/products_model.dart';

class HomeModel {
  late bool status;
  late String message;
  late dynamic data;
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  late String? ad;

  HomeModel.fromJson(Map<String, dynamic> json, {required List<ProductModel> productsList}) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'];

    if (data != null) {
      for (var element in data['banners']) {
        banners.add(BannerModel.fromJson(element));
      }

      for (var elementData in data['products']) {
        final product = productsList.where((element) => element.id == elementData['id']).first;
        products.add(product);
      }

      ad = data['ad'].toString();
    }
  }
}

class BannerModel {
  late int id;
  late String image;
  late String category;
  late String product;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'].toString();
    category = json['category'].toString();
    product = json['product'].toString();
  }
}
