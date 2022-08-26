import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_jwt/module/book.dart';
import 'package:test_jwt/service/local_storage_service.dart';

part 'api_common.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:5000")
abstract class ApiCommonClient {
  factory ApiCommonClient(Dio dio, {String? baseUrl}) {
    dio.interceptors.clear();
    dio.options = BaseOptions(receiveTimeout: 60000, connectTimeout: 60000);
    dio.options.headers.addAll({
      'Authorization': "Bearer ${LocalStorageService.getToken()}",
    });
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    dio.interceptors.add(InterceptorsWrapper(onError: (error, s) async {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      if (error.response == null) {}

      if (error.response?.statusCode != 200) {
        // EasyLoading.showError(error.message);

      }
    }));
    return _ApiCommonClient(dio, baseUrl: baseUrl);
  }

  @GET("/books")
  Future<List<Book>> getBooks();
}
