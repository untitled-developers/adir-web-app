import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget descriptionWidget(BuildContext context, int questionIndex) {
  return Center(
      child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Text(
            getDescription(context, questionIndex),
            textAlign: TextAlign.center,
          )));
}

String getDescription(BuildContext context, int i) {
  String? userName =
      Provider.of<PrefsData>(context, listen: false).user?.firstName ?? 'User';
  switch (i) {
    case 0:
      return 'I will accompany you on this journey to help protect your lifestyle.';
    case 1:
      return 'We’re only two steps away from giving you a quote.';
    case 2:
      return 'One step away & the quote is yours';
    case -1:
      return 'Oh! I forgot to ask your name so I can get in touch with you.';
    case 3:
      return 'Hi $userName, We have two options for you please pick one';
    case 4:
      return 'Hi $userName,\n\nWould you like to add a compulsory policy?';
    case 5:
      return 'Hi $userName,\nLast but not Least\n\nDo you have some more information about the car?';
    case 7:
      return 'Hi $userName,\n\nI am ready to issue the policy\nPlease let me know,';
    case 8:
      return 'Hi $userName,\n\nI just need two more minutes of your time to issue the policy.';
  }
  return '';
}
