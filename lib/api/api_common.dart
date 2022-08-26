import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_jwt/models/book.dart';
import 'package:test_jwt/models/get_book.dart';
import 'package:test_jwt/models/token.dart';
import 'package:test_jwt/models/user.dart';
import 'package:test_jwt/services/common_service.dart';
import 'package:test_jwt/services/local_storage_service.dart';

part 'api_common.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:5000")
abstract class ApiCommonClient {
  factory ApiCommonClient(Dio dio, {String? baseUrl}) {
    dio.interceptors.clear();
    dio.options = BaseOptions(receiveTimeout: 60000, connectTimeout: 60000);
    dio.options.headers.addAll({
      'Authorization': "Bearer ${LocalStorageService.getAccessToken()}",
    });
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    dio.interceptors.add(InterceptorsWrapper(onError: (error, s) async {
      // if (EasyLoading.isShow) {
      //   EasyLoading.dismiss();
      // }
      // if (error.response == null) {}

      // if (error.response?.statusCode != 200) {
      //   EasyLoading.showError(error.message);
      // } else if (error.response?.statusCode == 403) {
      //   // todo
      // }
      if (error.response?.statusCode == 403) {
        final commonService = Get.find<CommonService>();
        await commonService.refreshToken();
        error.requestOptions.headers["Authorization"] =
            "Bearer ${LocalStorageService.getAccessToken()}";
        //create request with new access token
        final opts = Options(headers: error.requestOptions.headers);
        final cloneReq = await dio.request(
          "http://10.0.2.2:5000${error.requestOptions.path}",
          options: opts,
        );

        return s.resolve(cloneReq);
      }
    }));

    return _ApiCommonClient(dio, baseUrl: baseUrl);
  }

  @GET("/books")
  Future<GetBooks> getBooks();

  @POST("/login")
  Future<Token> login(@Body() User user);

  @POST("/refreshToken")
  Future<Token> refreshToken(@Field("refreshToken") String refreshToken);
}
