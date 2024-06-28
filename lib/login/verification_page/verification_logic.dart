part of 'verification_page.dart';

// ignore: library_private_types_in_public_api
extension VerificationPageCode on _VerificationPageState {
  validatePin(value) {
    String validDigit = widget.phoneVerification['verification_code'];
    if (value.toString() == validDigit) {
      validPin = true;
      setState(() {});
      return null;
    }
    return 'Pin is incorrect';
  }

  _verifySMSCode(String pin) {
    DialogUtils.showProgressDialog(context);

    Session()
        .loginClient
        .login(
            verificationId: widget.verificationId,
            verificationCode: pin,
            name: widget.name ?? '',
            payLoad: Provider.of<PrefsData>(context, listen: false).questions,
            version: 1)
        .then((response) async {
      String token = response['access_token'];

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
          Map<String, dynamic> submittedQuestions =
              jsonDecode(response['submission']['payload']);

          compareWithProviderData(submittedQuestions);
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
    }).catchError((error, stack) {
      logger.e('Error', error: error, stackTrace: stack);
      if (mounted) {
        if (error is DioException && error.response != null) {
          DialogUtils.showErrorDialog(context,
              body: Text(
                error.response!.data['message'],
              ),
              onOk: () => Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          QuestionsPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero),
                  (route) => false));
        } else {
          DialogUtils.showErrorDialog(
            context,
            body: const Text("Error while editing info."),
          );
        }
      }
    });
  }

  compareWithProviderData(Map<String, dynamic> submittedMap) {
    bool isDifferent = false;
    submittedMap.entries.take(3).forEach((entry) {
      if (providerQuestions[entry.key]['answer'] != null &&
          providerQuestions[entry.key]['answer'].toString().isNotEmpty) {
        if (entry.value['answer'].toString().isNotEmpty &&
            entry.value['answer'] != providerQuestions[entry.key]['answer']) {
          setState(() => isDifferent = true);
          DialogUtils.showNotifyDialog(
            context,
            body: const Text(
                "We've noticed that you have different answers for the first three initial questions, than the ones submitted before. Do you wish to update yoour answers, or keep the old ones?"),
            actions: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Provider.of<PrefsData>(context, listen: false)
                            .updateQuestions(submittedMap);
                        Navigator.of(context).pushAndRemoveUntil(
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        QuestionsPage(
                                          index: 3,
                                        ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text('Keep my old answers',
                          style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white),
                      onPressed: () => onUpdateAnswers(submittedMap),
                      child: const Text('Update my answers',
                          style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }
    });

    if (!isDifferent) {
      Provider.of<PrefsData>(context, listen: false)
          .updateQuestions(submittedMap);
      Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => QuestionsPage(
                    index: 3,
                  ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero),
          (Route<dynamic> route) => false);
    }
  }
}
