part of 'login_page.dart';

extension LoginPageDesignLogic on _LoginPageState {
  onLogIn() async {
    if (validPhoneNumber == true) {
      //TODO remove this:
      Provider.of<PrefsData>(context, listen: false).updateQuestions(questions);

      String device = await getDevice();
      //TODO uncomment this when api's ready
      Session()
          .loginClient
          .requestSms(
              phone: phoneNumberController.getParsedPhoneNumber(),
              device: device)
          .then((Map<String, dynamic> phoneVerification) async {
        Navigator.of(context).pop();
        _verificationId = phoneVerification['id'];
        //_verificationId = 123;
        //phoneVerification['next_request_at'] = '2024-12-12';
        Navigator.push(
            context,
            SlideRoute(
              page: VerificationPage(
                phoneNumber: phoneNumberController.getParsedPhoneNumber(),
                verificationId: _verificationId,
                phoneVerification: phoneVerification,
                //phoneVerification: phoneVerification,
              ),
            ));
      }).catchError((error, stack) async {
        // Navigator.of(context).pop();
        logger.e('Login', error: error, stackTrace: stack);
        try {
          Response? response = error.response;
          if (response != null && response.statusCode == 400) {
            String message = response.data['message'];
            if (message == 'You cannot request another SMS yet!') {
              //Should navigate to PIN page
              Map<String, dynamic> phoneVerification =
                  response.data['phone_verification'];

              _verificationId = phoneVerification['id'];
              Navigator.pushReplacement(
                context,
                SlideRoute(
                  page: VerificationPage(
                    phoneNumber: phoneNumberController.getParsedPhoneNumber(),
                    verificationId: _verificationId,
                    phoneVerification: phoneVerification,
                  ),
                ),
              );
            }
          } else {
            logger.e('Login', error: error, stackTrace: stack);
            var sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.remove('phoneNumberForVerification');
            sharedPreferences.remove('idForVerification');
            if (mounted) {
              DialogUtils.showErrorDialog(context,
                  body: const Text('An Error Occurred'), onOk: () {});
            }
          }
        } on NoSuchMethodError catch (error, stack) {
          logger.e('Login', error: error, stackTrace: stack);
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.remove('phoneNumberForVerification');
          sharedPreferences.remove('idForVerification');

          if (mounted) {
            DialogUtils.showErrorDialog(context,
                body: const Text('An Error Occurred'), onOk: () {});
          }
        }
      });
    }
  }

  onMobileTextChange(text) async {
    isCheckingPhoneNumber =
        phoneNumberController.textController.text.isNotEmpty;
    validPhoneNumber = phoneNumberController.textController.text.isNotEmpty
        ? await phoneNumberController.phoneNumberValid()
        : false;
    if (validPhoneNumber == true) isCheckingPhoneNumber = false;
    setState(() {});
  }

  onEditingComplete() => setState(() => isCheckingPhoneNumber = false);
}
