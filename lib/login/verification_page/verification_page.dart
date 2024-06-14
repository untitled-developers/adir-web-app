import 'dart:async';

import 'package:adir_web_app/api/session.dart';
import 'package:adir_web_app/common/slide_route.dart';
import 'package:adir_web_app/login/login_page.dart';
import 'package:adir_web_app/main.dart';
import 'package:adir_web_app/pages/questions_page/questions_page.dart';
import 'package:adir_web_app/utils/dialog_utils.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pinput.dart';
part 'verification_design_logic.dart';
part 'verification_logic.dart';

class VerificationPage extends StatefulWidget {
  final int verificationId;
  final String phoneNumber;
  final Map<String, dynamic> phoneVerification;

  const VerificationPage({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
    required this.phoneVerification,
  }) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  Timer? countdownTimer;
  late Duration myDuration;
  final TextEditingController _pinPutController = TextEditingController();
  bool finishedProfile = false;
  bool validPin = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      value.setString('phoneNumberForVerification', widget.phoneNumber);
      value.setInt('idForVerification', widget.verificationId);
    });

    myDuration = Duration(
        seconds: DateTime.parse(widget.phoneVerification['next_request_at'])
            .difference(DateTime.now())
            .inSeconds);
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => _setCountDown());
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final hours = strDigits(myDuration.inHours.remainder(60));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 450
                ? 450
                : MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: _onBackgroundTap,
                child: Container(
                  color: Colors.transparent,
                  child: Column(children: [
                    SizedBox(height: screenHeight * 0.05),
                    const Text(
                      'Verification Code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Code is sent to ${widget.phoneNumber}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    pinPutWidget(),
                    const SizedBox(height: 37),
                    const Text("Didn't receive the code?",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 40),
                    if (hours == '00' && minutes == '00' && seconds == '00')
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Resend new code',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ),
                    const SizedBox(height: 22),
                    if (!(hours == '00' && minutes == '00' && seconds == '00'))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Try again in',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            '$hours:$minutes:$seconds',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                        ],
                      ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: screenWidth * 0.55,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 42),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () => validPin
                              ? _verifySMSCode(_pinPutController.text)
                              : {},
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: _changePhoneNumber,
                      child: const Text(
                        'Change phone number',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
