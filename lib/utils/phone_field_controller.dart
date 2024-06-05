import 'package:adir_web_app/main.dart';
import 'package:flutter/material.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart' as phoneLib;

class PhoneFieldController {
  late TextEditingController textController;
  String countryCode;

  PhoneFieldController(
      {required this.textController,
      this.countryCode = '+961',
      String? initialPhoneNumber}) {
    if (initialPhoneNumber != null) {
      parsePhoneNumber(initialPhoneNumber);
    }
  }

  String get text {
    String phone = '';
    if (textController.text.startsWith('0')) {
      phone = textController.text.replaceFirst('0', '');
    } else {
      phone = textController.text;
    }

    while (phone.startsWith('0')) {
      phone = phone.replaceFirst('0', '');
    }
    if (phone == '') return '';
    return countryCode + phone;
  }

  parsePhoneNumber(String phoneNumber) {
    logger.d('Parsing Phone: $phoneNumber');
    try {
      phoneLib.PhoneNumber number = phoneLib.PhoneNumber.parse(phoneNumber);
      countryCode = '+${number.countryCode}';
      textController.text = number.nsn;
    } catch (_) {
      textController.text = '';
      logger.e('Failed to parse $_');
    }
  }

  phoneNumberValid() {
    final phoneNumber = phoneLib.PhoneNumber.parse(text);
    return phoneNumber.isValid();
  }

  String getParsedPhoneNumber() {
    final phoneNumber = phoneLib.PhoneNumber.parse(text);
    return '+${phoneNumber.countryCode}${phoneNumber.nsn}';
  }
}
