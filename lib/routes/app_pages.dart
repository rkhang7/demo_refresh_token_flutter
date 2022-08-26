import 'package:get/get.dart';
import 'package:test_jwt/modules/home/home_binding.dart';
import 'package:test_jwt/modules/home/home_page.dart';
import 'package:test_jwt/modules/login/login_binding.dart';
import 'package:test_jwt/modules/login/login_page.dart';
import 'package:test_jwt/routes/app_routes.dart';

class AppPages {
  static var getPages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
