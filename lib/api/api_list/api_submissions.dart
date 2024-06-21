import 'package:dio/dio.dart';

class SubmissionsAPI {
  late final Dio _dio;

  SubmissionsAPI(this._dio);

  Future<Response> getSubmission() async {
    try {
      Response response = await _dio.request(
        "/user/submission",
        options: Options(method: "GET"),
      );
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> submitQuestions(
    Map<String, dynamic> data,
  ) async {
    FormData formData = FormData.fromMap(data);
    try {
      Response response = await _dio.request(
        "/user/submit",
        data: formData,
        options: Options(
          method: "POST",
        ),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
