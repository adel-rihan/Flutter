import 'package:flutter/material.dart';

class Routes {
  static String home = '/';
  static String result = '/result';

  static navTo(context, String route, {Map? args}) =>
      Navigator.pushNamed(context, route, arguments: args);

  static pushResult(context) => navTo(context, result);
}
