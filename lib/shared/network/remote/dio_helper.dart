import 'package:dio/dio.dart';

class dioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
        BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,

    )
    );
  }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token

  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token??'' ,
      'Content-Type': 'application/json',
    }; //لانها متغيرة

    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> putData({
    required String url,
    required Map<String , dynamic> data ,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token

  }) async {
    dio!.options.headers = {
      'lang': lang,
    'Authorization': token??'' ,
      'Content-Type': 'application/json',
    }; //لانها متغيرة

    return await dio!.put(url, queryParameters: query , data: data);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token

  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '' ,
      'Content-Type': 'application/json',

    }; //لانها متغيرة

    return await dio!.post(url,
        queryParameters: query,
        data: data
    );
  }
}