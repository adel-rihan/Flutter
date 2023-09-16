import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> get({
    required String url,
    String? token,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {
          'lang': lang,
          'Authorization': token.toString(),
        },
      ),
    );
  }

  static Future<Response> post({
    required String url,
    String? token,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          'lang': lang,
          'Authorization': token.toString(),
        },
      ),
    );
  }

  static Future<Response> put({
    required String url,
    String? token,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          'lang': lang,
          'Authorization': token.toString(),
        },
      ),
    );
  }

  static Future<Response> delete({
    required String url,
    String? token,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          'lang': lang,
          'Authorization': token.toString(),
        },
      ),
    );
  }
}
