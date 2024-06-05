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
}
