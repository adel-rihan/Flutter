import 'package:shop/models/favorites_model.dart';

class ProductsModel {
  late bool status;
  late String message;
  late dynamic data;
  List<ProductModel> products = [];
  List<ProductModel> favorites = [];
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

  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'];

    if (data != null) {
      List<dynamic> productsList = data['data'];
      for (var element in productsList) {
        products.add(ProductModel.fromJson(element));
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

  getFavorites({required FavoritesModel model}) {
    for (var favorite in model.favorites) {
      final product = products.where((element) => element.id == favorite.id).first;
      favorites.add(product);
    }
  }

  changeFavorite({required bool favorite, required ProductModel model}) {
    model.inFavorites = favorite;

    if (favorite) {
      favorites.add(model);
    } else {
      favorites.remove(model);
    }
  }
}

class ProductModel {
  late int id;
  late double price;
  late double oldPrice;
  late double discount;
  late String image;
  late String name;
  late String description;
  late List<dynamic> images;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = double.parse(json['price'].toString());
    oldPrice = double.parse(json['old_price'].toString());
    discount = double.parse(json['discount'].toString());
    image = json['image'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
