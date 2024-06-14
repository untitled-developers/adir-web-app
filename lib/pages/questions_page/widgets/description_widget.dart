import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget descriptionWidget(BuildContext context, int questionIndex) {
  return Center(
      child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Text(getDescription(context, questionIndex))));
}

String getDescription(BuildContext context, int i) {
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
      String? userName =
          Provider.of<PrefsData>(context, listen: false).user?.firstName ?? '';
      return 'Hi $userName, We have two options for you please pick one';
  }
  return '';
}
