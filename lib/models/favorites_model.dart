class FavoritesModel {
  late bool status;
  late String message;
  late dynamic data;
  List<FavoriteModel> favorites = [];
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

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'];

    if (data != null) {
      List<dynamic> favoritesList = data['data'];
      for (var element in favoritesList) {
        favorites.add(FavoriteModel.fromJson(element));
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

class FavoriteModel {
  late int favID;
  late int id;
  late double price;
  late double oldPrice;
  late double discount;
  late String image;
  late String name;
  late String description;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    var product = json['product'];
    favID = json['id'];
    id = product['id'];
    price = double.parse(product['price'].toString());
    oldPrice = double.parse(product['old_price'].toString());
    discount = double.parse(product['discount'].toString());
    image = product['image'].toString();
    name = product['name'].toString();
    description = product['description'].toString();
  }
}
