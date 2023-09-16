import 'package:flutter/material.dart';
import 'package:shop/layouts/shop_layout.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/modules/layout/product_page.dart';
import 'package:shop/modules/user/login_page.dart';
import 'package:shop/modules/start/on_boarding_page.dart';
import 'package:shop/modules/layout/search_page.dart';
import 'package:shop/modules/user/signup_page.dart';
import 'package:shop/modules/layout/profile/update_password_page.dart';
import 'package:shop/modules/layout/profile/update_profile_page.dart';

class Routes {
  static navTo(context, page) => Navigator.push(context, MaterialPageRoute(builder: (context) => page));

  static navToR(context, page) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));

  static pushOnBoarding(context) => navToR(context, const OnBoardingPage());

  static pushLogin(context) => navToR(context, const LoginPage());

  static pushSignUp(context) => navTo(context, const SignUpPage());

  static pushShop(context) => navToR(context, const ShopLayout());

  static pushProduct(context, {required ProductModel model}) => navTo(context, ProductPage(model: model));

  static pushSearch(context) => navTo(context, const SearchPage());

  static pushUpdatePassword(context) => navTo(context, const UpdatePasswordPage());

  static pushUpdateProfile(context) => navTo(context, const UpdateProfilePage());
}
