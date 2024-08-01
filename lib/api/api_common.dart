import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_jwt/models/token.dart';
import 'package:test_jwt/models/user.dart';
import 'package:test_jwt/services/common_service.dart';
import 'package:test_jwt/services/local_storage_service.dart';

part 'api_common.g.dart';

@RestApi(baseUrl: "http://192.168.100.32:3000")
abstract class ApiCommonClient {
  factory ApiCommonClient(Dio dio, {String? baseUrl}) {
    dio.interceptors.clear();
    // dio.options = BaseOptions(receiveTimeout: 60000, connectTimeout: 60000);
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
      if (error.response?.statusCode == 401) {
        final commonService = Get.find<CommonService>();
        await commonService.refreshToken();
        error.requestOptions.headers["Authorization"] =
            "Bearer ${LocalStorageService.getAccessToken()}";
        //create request with new access token
        final opts = Options(headers: error.requestOptions.headers);
        final cloneReq = await dio.request(
          "http://192.168.100.32:3000${error.requestOptions.path}",
          options: opts,
        );

        return s.resolve(cloneReq);
      }
    }));

    return _ApiCommonClient(dio, baseUrl: baseUrl);
  }

  @GET("/users")
  Future<List<User>> getUsers();

  @POST("/login")
  Future<Token> login(@Body() User user);

  @POST("/token")
  Future<Token> refreshToken(@Field("token") String refreshToken);
}
