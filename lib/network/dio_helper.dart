import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static int() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.goldapi.io/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(String url) async {
    dio!.options.headers = {'x-access-token': 'goldapi-1km8arljumw7di-io'};
    return await dio!.get(url);
  }
}
