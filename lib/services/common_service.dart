import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_jwt/models/book.dart';
import 'package:test_jwt/models/get_book.dart';
import 'package:test_jwt/models/user.dart';
import 'package:test_jwt/repositories/common_repository.dart';
import 'package:test_jwt/services/local_storage_service.dart';

class CommonService extends GetxService {
  CommonRepository commonRepository = CommonRepository();

  Future<void> login(
      {required String userName, required String password}) async {
    await commonRepository
        .login(user: User(userName: userName, password: password))
        .then((value) {
      // save token && accessToken

      LocalStorageService.setAccessToken(value.accessToken);
      LocalStorageService.setRefreshToken(value.refreshToken ?? "");
    });
  }

  Future<GetBooks> getBooks() async {
    return await commonRepository.getBooks();
  }

  Future<void> refreshToken() async {
    await commonRepository
        .refreshToken(
      refreshToken: LocalStorageService.getRefreshToken(),
    )
        .then((value) {
      // set token again
      LocalStorageService.setAccessToken(value.accessToken);
    });
  }
}
