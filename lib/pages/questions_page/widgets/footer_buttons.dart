import 'package:adir_web_app/login/login_page.dart';
import 'package:flutter/material.dart';

Widget footerButtons(BuildContext context, bool showContinueYourJourney) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (showContinueYourJourney)
        TextButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage())),
            child: Text('Continue Your Journey')),
      TextButton(onPressed: () {}, child: Text('Contact Us')),
    ],
  );
}
