import 'package:adir_web_app/login/login_page.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget footerButtons(BuildContext context, bool showContinueYourJourney) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (showContinueYourJourney)
        TextButton(
            onPressed: () {
              Provider.of<PrefsData>(context, listen: false)
                  .updateAnswer('carbrand', '');
              Provider.of<PrefsData>(context, listen: false)
                  .updateAnswer('carvalue', '');
              Provider.of<PrefsData>(context, listen: false)
                  .updateAnswer('yearofmake', '');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text('Continue Your Journey')),
      TextButton(onPressed: () {}, child: Text('Contact Us')),
    ],
  );
}
