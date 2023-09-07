import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    String? url,
    required Map<String, dynamic> query,
    bool search = false,
  }) async {
    url = search ? 'v2/everything' : 'v2/top-headlines';
    query = {...query, 'apiKey': 'f62d22e3f44b40aaa183addd6517f04e'};
    // f62d22e3f44b40aaa183addd6517f04e
    // 65f7f556ec76449fa7dc7c0069f040ca
    if (!search) query = {...query, 'country': 'eg'};

    return await dio!.get(url, queryParameters: query);
  }
}
