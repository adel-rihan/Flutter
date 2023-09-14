import 'package:flutter/material.dart';

class Routes {
  static String home = '/';
  static String search = '/search';
  static String webview = '/webview';

  static navTo(context, String route, {Map? args}) => Navigator.pushNamed(context, route, arguments: args);

  static pushSearch(context) => navTo(context, search);

  static pushWebView(context, Map args) => navTo(context, webview, args: args);
}
