import 'package:get/get.dart';
import 'package:test_jwt/services/common_service.dart';

class HomeController extends GetxController {
  var listUser = [].obs;
  final commonService = Get.find<CommonService>();
  void fetchApi() {
    listUser.clear();
    commonService.getUsers().then(
      (value) {
        if (value.isNotEmpty) {
          listUser.assignAll(value);
        } else {}
      },
    );
  }
}
