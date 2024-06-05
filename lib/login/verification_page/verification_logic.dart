part of 'verification_page.dart';

// ignore: library_private_types_in_public_api
extension VerificationPageCode on _VerificationPageState {
  _verifySMSCode(String pin) {
    DialogUtils.showProgressDialog(context);
    Session()
        .loginClient
        .login(verificationId: widget.verificationId, verificationCode: pin)
        .then((String token) async {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove('phoneNumberForVerification');
      sharedPreferences.remove('idForVerification');
      logger.i('accessToken: $token');
      Session().accessToken = token;

      Session().getLoggedInUser().then((user) async {
        //TODO Add the things related to firebase
        Provider.of<PrefsData>(context, listen: false).updateUser(user);

        if (mounted) {
          Session().init(context, user!);
          if (!mounted) return;
          Navigator.pop(context);

          if (!kIsWeb) {
            storage.write(key: 'accessToken', value: token);
          }
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
        }
      }).catchError((error, stack) async {
        logger.e('Error', error: error, stackTrace: stack);
        Navigator.of(context).pop();
        Response response = error.response;
        if (response.statusCode == 422) {
          if (response.data['message'].contains('expired')) {
            DialogUtils.showErrorDialog(context,
                body: const Text('Verification Expired! Please try again!'),
                onOk: () async {
              var sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove('phoneNumberForVerification');
              sharedPreferences.remove('idForVerification');

              if (mounted) {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, SlideRoute(page: const LoginPage()));
              }
            });
          } else if (response.data['message'] == 'Invalid verification code!') {
            DialogUtils.showErrorDialog(context,
                body: const Text('Invalid Verification Code!'), onOk: () {});
          }
        } else {
          DialogUtils.showErrorDialog(context,
              body: const Text('An Error Occurred!'), onOk: () {});
        }
      });
    });
  }
}
