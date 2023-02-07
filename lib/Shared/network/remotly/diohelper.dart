import 'package:dio/dio.dart';

class diohelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,

        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        }
    ));
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? qurery,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio!.get(path, queryParameters: qurery);
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? qurery,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio!.post(
        path,
        queryParameters: qurery,
        data: data
    );
  }

  static Future<Response> PutData({
    required String path,
    Map<String, dynamic>? qurery,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio!.put(path, queryParameters: qurery, data: data);
  }
}