import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static String getAccessToken() {
    return instance.getString("accessToken") ?? "";
  }

  static void setAccessToken(String value) async {
    instance.setString("accessToken", value);
  }

  static String getRefreshToken() {
    return instance.getString("refreshToken") ?? "";
  }

  static void setRefreshToken(String value) async {
    instance.setString("refreshToken", value);
  }
}
