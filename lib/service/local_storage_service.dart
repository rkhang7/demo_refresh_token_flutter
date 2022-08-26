import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static String getToken() {
    return instance.getString("accessToken") ?? "";
  }

  static void setToken(String value) async {
    instance.setString("accessToken", value);
  }
}
