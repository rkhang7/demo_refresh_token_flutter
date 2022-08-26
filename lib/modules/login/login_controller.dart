import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_jwt/routes/app_routes.dart';
import 'package:test_jwt/services/common_service.dart';

class LoginController extends GetxController {
  final userNameController = TextEditingController(text: "abc");
  final passwordController = TextEditingController(text: "asdjasbd");

  final commonService = Get.find<CommonService>();

  void login() {
    commonService
        .login(
            userName: userNameController.text,
            password: passwordController.text)
        .then((value) {
      Get.offAndToNamed(AppRoutes.HOME);
    });
  }
}
