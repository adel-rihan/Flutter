class CategoriesModel {
  late bool status;
  late String message;
  late dynamic data;
  List<CategoryModel> categories = [];
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

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'];

    if (data != null) {
      List<dynamic> categoriesList = data['data'];
      for (var element in categoriesList) {
        categories.add(CategoryModel.fromJson(element));
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

class CategoryModel {
  late int id;
  late String name;
  late String image;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    image = json['image'].toString();
  }
}
