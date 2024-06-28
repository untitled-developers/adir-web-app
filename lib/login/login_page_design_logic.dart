part of 'login_page.dart';

extension LoginPageDesignLogic on _LoginPageState {
  onLogIn() async {
    setState(() => validPhoneNumber = phoneNumberController.text.isNotEmpty);

    if (_formKey.currentState!.validate() && validPhoneNumber == true) {
      if (validPhoneNumber == true) {
        String device = await getDevice();
        Session()
            .loginClient
            .requestSms(
                phone: phoneNumberController.getParsedPhoneNumber(),
                device: device)
            .then((Map<String, dynamic> phoneVerification) async {
          Navigator.of(context).pop();
          _verificationId = phoneVerification['id'];

          Navigator.push(
              context,
              SlideRoute(
                page: VerificationPage(
                  phoneNumber: phoneNumberController.getParsedPhoneNumber(),
                  verificationId: _verificationId,
                  phoneVerification: phoneVerification,
                  name: nameController.text,
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
                      name: nameController.text,
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
                    body: const Text('An Error Occurred'),
                    onOk: () => Navigator.of(context).pop());
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
