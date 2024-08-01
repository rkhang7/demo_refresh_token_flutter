import 'package:dio/dio.dart';
import 'package:test_jwt/api/api_common.dart';
import 'package:test_jwt/models/token.dart';
import 'package:test_jwt/models/user.dart';

class CommonRepository {
  Dio dio = Dio();

  Future<List<User>> getUsers() async {
    final client = ApiCommonClient(dio);
    return await client.getUsers();
  }

  Future<Token> login({required User user}) async {
    final client = ApiCommonClient(dio);
    return await client.login(user);
  }

  Future<Token> refreshToken({required String refreshToken}) async {
    final client = ApiCommonClient(dio);
    return await client.refreshToken(refreshToken);
  }
}
