import 'dart:io' as io;

import 'package:adir_web_app/api/session.dart';
import 'package:adir_web_app/common/slide_route.dart';
import 'package:adir_web_app/common/widgets/textField.dart';
import 'package:adir_web_app/login/verification_page/verification_page.dart';
import 'package:adir_web_app/main.dart';
import 'package:adir_web_app/pages/questions_page/widgets/description_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/hello_im_lisa_widget.dart';
import 'package:adir_web_app/utils/dialog_utils.dart';
import 'package:adir_web_app/utils/phone_field_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart';

part 'login_page_design_logic.dart';
part 'login_page_logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late PhoneFieldController phoneNumberController = PhoneFieldController(
    textController: TextEditingController(),
  );
  TextEditingController nameController = TextEditingController();
  bool isCheckingPhoneNumber = false;
  bool? validPhoneNumber;
  final _formKey = GlobalKey<FormState>();
  late int _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    helloImLisaWidget(),
                    descriptionWidget(context, -1),
                    const SizedBox(height: 50),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: textField(
                          label: 'First Name',
                          isValid: nameController.text.isEmpty,
                          controller: nameController,
                          enabled: true,
                        )),
                    const SizedBox(height: 20),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: validPhoneNumber == null ||
                                    validPhoneNumber == true
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.red,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      bottomLeft: Radius.circular(14)),
                                  color: Color.fromRGBO(120, 120, 120, 0.1)),
                              width: 50,
                              height: 60,
                              child: const Center(child: Text('+961')),
                            ),
                            Expanded(
                              child: TextFormField(
                                  controller:
                                      phoneNumberController.textController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(color: Colors.black),
                                  cursorHeight: 20,
                                  cursorColor: Theme.of(context).primaryColor,
                                  onChanged: onMobileTextChange,
                                  onEditingComplete: onEditingComplete,
                                  decoration: InputDecoration(
                                    suffixIcon: isCheckingPhoneNumber
                                        ? Transform.scale(
                                            scale: 0.5,
                                            child:
                                                const CircularProgressIndicator())
                                        : validPhoneNumber == true
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Image.asset(
                                                  'assets/icons/tick.png',
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              )
                                            : null,
                                    counter: const Offstage(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    floatingLabelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    labelText: 'Phone Number',
                                    border: InputBorder.none,
                                  )),
                            ),
                          ],
                        )),
                    validPhoneNumber == false
                        ? const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Invalid phone number.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Back'),
                            ),
                            const SizedBox(width: 50),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white),
                              onPressed: onLogIn,
                              child: const Text('Next'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
