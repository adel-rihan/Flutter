class LoginModel {
  late bool status;
  late String message;
  late UserModel? userModel;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }
}

class UserModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    image = json['image'].toString();
    if (json['points'] != null) points = json['points'];
    if (json['credit'] != null) credit = json['credit'];
    token = json['token'].toString();
  }

  updateProfile(Map<String, dynamic> json) {
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
  }
}
