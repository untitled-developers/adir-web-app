import 'package:adir_web_app/api/api_list/api_users.dart';
import 'package:adir_web_app/api/session.dart';
import 'package:adir_web_app/main.dart';
import 'package:dio/dio.dart';

const domainUrl = "http://192.168.0.115:8000";

const baseUrl = "$domainUrl/api";

class ApiClient {
  Dio? _dio;
  late final UsersAPI usersAPI;

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: 20000),
      receiveTimeout: Duration(milliseconds: 30000),
      responseType: ResponseType.json,
      headers: {'accept': 'application/json'},
    );
    _dio = Dio(options);
    _dio!.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      logger.i('${options.method}: ${options.uri}');
      options.headers['accepts'] = 'application/json';
      options.headers['Authorization'] =
          'Bearer ' + (Session().accessToken ?? '');
      return handler.next(options);
    }, onResponse: (Response response, handler) async {
      logger.i(
          '(${response.statusCode}) ${response.requestOptions.method}: ${response.requestOptions.uri} \n ${response.data}');
      return handler.next(response);
    }, onError: (DioException e, handler) async {
      if (e.response != null) {
        logger.e(
            '(${e.response!.statusCode}) ${e.response!.requestOptions.method}: ${e.response!.requestOptions.uri} \n ${e.response!.data}');
      } else {
        logger.e(e);
      }
      return handler.next(e); //continue
    }));

    initializeApiRequests();
  }

  void initializeApiRequests() {
    usersAPI = UsersAPI(_dio!);
  }
}

class LoginApiClient {
  Dio? _dio;

  LoginApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: 20000),
      receiveTimeout: Duration(milliseconds: 30000),
      responseType: ResponseType.json,
      headers: {'accept': 'application/json'},
    );
    _dio = Dio(options);

    _dio!.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      logger.i('${options.method}: ${options.uri}');
      return handler.next(options);
    }, onResponse: (Response response, handler) async {
      logger.i(
          '(${response.statusCode}) ${response.requestOptions.data}: ${response.requestOptions.uri} \n ${response.data}');
      return handler.next(response);
    }, onError: (DioException e, handler) async {
      if (e.response != null) {
        logger.e(
            '(${e.response!.statusCode}) ${e.response!.requestOptions.method}: ${e.response!.requestOptions.uri} \n ${e.response!.data}');
      } else {
        logger.e(e);
      }
      return handler.next(e);
    }));
  }

  Future<Map<String, dynamic>> requestSms(
      {required String phone, required String device}) async {
    try {
      Response response = await _dio!.request(
        "/request-sms",
        data: {'phone': phone, 'device': device},
        options: Options(
          method: "POST",
        ),
      );
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> login(
      {required String verificationCode, required int verificationId}) async {
    try {
      Response response = await _dio!.request(
        "/login",
        data: {
          'verification_code': verificationCode,
          'verification_id': verificationId
        },
        options: Options(
          method: "POST",
        ),
      );
      return response.data['access_token'];
    } catch (error) {
      rethrow;
    }
  }
}
