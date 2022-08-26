import 'package:get/get.dart';
import 'package:test_jwt/services/common_service.dart';

class HomeController extends GetxController {
  var listBook = [].obs;
  final commonService = Get.find<CommonService>();
  void fetchApi() {
    listBook.clear();
    commonService.getBooks().then(
      (value) {
        if (value.data.isNotEmpty) {
          listBook.assignAll(value.data);
        } else {}
      },
    );
  }
}
