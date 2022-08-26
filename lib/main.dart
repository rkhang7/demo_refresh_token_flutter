import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:test_jwt/api/api_common.dart';
import 'package:test_jwt/routes/app_pages.dart';
import 'package:test_jwt/routes/app_routes.dart';
import 'package:test_jwt/services/local_storage_service.dart';
import 'package:test_jwt/services/common_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialService();
  runApp(const MyApp());
}

Future<void> initialService() async {
  await Get.putAsync(() => LocalStorageService.init());
  Get.put(CommonService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.getPages,
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        return child;
      },
    );
  }
}
