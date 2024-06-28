import 'package:adir_web_app/login/login_page.dart';
import 'package:adir_web_app/main.dart';
import 'package:adir_web_app/models/user.dart';
import 'package:adir_web_app/utils/dialog_utils.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api_client.dart';

class Session {
  static final Session _session = Session._internal();

  factory Session() {
    return _session;
  }

  Session._internal();

  User? _loggedInUser;
  String? accessToken;
  String? mobileNumber;
  String? password;

  final ApiClient _apiClient = ApiClient();
  final LoginApiClient _loginApiClient = LoginApiClient();

  ApiClient get apiClient => _apiClient;

  LoginApiClient get loginClient => _loginApiClient;

  void init(BuildContext context, User user) {
    Provider.of<PrefsData>(context, listen: false).updateUser(user);
  }

  Future<void> syncUser(PrefsData prefsData) async {
    _loggedInUser = await apiClient.usersAPI.getLoggedInUser();
    prefsData.updateUser(_loggedInUser!);
  }

  Future<User?> getLoggedInUser() async {
    if (_loggedInUser != null) return _loggedInUser;
    try {
      _loggedInUser = await apiClient.usersAPI.getLoggedInUser();
      return _loggedInUser;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout(PrefsData prefsData, BuildContext context) async {
    try {
      DialogUtils.showProgressDialog(context);
      Session().mobileNumber = null;
      Session().password = null;
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => LoginPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero),
            (Route<dynamic> route) => false);
        storage.delete(key: 'accessToken');
        _loggedInUser = null;
        prefsData.updateUser(null);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      rethrow;
    }
  }
}
