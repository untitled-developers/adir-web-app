part of 'verification_page.dart';

// ignore: library_private_types_in_public_api
extension VerificationPageDesignCode on _VerificationPageState {
  _onBackgroundTap() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  _changePhoneNumber() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('phoneNumberForVerification');
    sharedPreferences.remove('idForVerification');
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          SlideRoute(page: const LoginPage()), (route) => false);
    }
  }

  _setCountDown() {
    setState(() {
      final seconds = myDuration.inSeconds - 1;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');

  Future<void> showVerifiedDialog(BuildContext context) async =>
      showDialog<void>(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            contentPadding: const EdgeInsets.only(top: 25),
            backgroundColor: const Color.fromRGBO(247, 255, 251, 1),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/check.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 15),
                const Text('Code Verified',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 24),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          );
        },
      );

  onUpdateAnswers(Map<String, dynamic> submittedMap) {
    Map<String, dynamic> updatedMap = {};
    providerQuestions.entries.take(3).forEach((entry) {
      updatedMap[entry.key] = entry.value;
    });

    submittedMap.entries.skip(3).forEach((entry) {
      updatedMap[entry.key] = entry.value;
    });
    Map<String, dynamic> data = {
      "version": 1,
      "is_draft": true,
      "form_finished_percentage": 20,
      "payload": providerQuestions,
    };
    Session().apiClient.submissionsAPI.submitQuestions(data).then((response) {
      Provider.of<PrefsData>(context, listen: false)
          .updateQuestions(providerQuestions);
      Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => QuestionsPage(
                    index: 3,
                  ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero),
          (Route<dynamic> route) => false);
    }).catchError((error, stack) {
      logger.e('Error', error: error, stackTrace: stack);
      if (mounted) {
        if (error is DioException && error.response != null) {
          DialogUtils.showErrorDialog(
            context,
            body: Text(
              error.response!.data['message'],
            ),
          );
        } else {
          DialogUtils.showErrorDialog(
            context,
            body: const Text("Error while saving data."),
          );
        }
      }
    });
  }
}
