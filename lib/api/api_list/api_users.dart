import 'package:adir_web_app/models/user.dart';
import 'package:dio/dio.dart';

class UsersAPI {
  late final Dio _dio;

  UsersAPI(this._dio);

  Future<User> getLoggedInUser() async {
    try {
      Response response = await _dio.request(
        "/user",
        options: Options(method: "GET"),
      );
      return User.fromMap(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<User> createUser(
    String? phoneNumber,
    String? pass,
  ) async {
    Map<String, dynamic> data = {
      'phone': phoneNumber,
      'password': pass,
    };

    FormData formData = FormData.fromMap(data);
    try {
      Response response = await _dio.request(
        "/user/create",
        data: formData,
        options: Options(
          method: "POST",
        ),
      );
      return User.fromMap(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
