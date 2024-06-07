import 'package:adir_web_app/api/session.dart';
import 'package:adir_web_app/common/widgets/date_picker_widget.dart';
import 'package:adir_web_app/common/widgets/native_drop_down_field.dart';
import 'package:adir_web_app/common/widgets/textField.dart';
import 'package:adir_web_app/main.dart';
import 'package:adir_web_app/models/user.dart';
import 'package:adir_web_app/utils/dialog_utils.dart';
import 'package:adir_web_app/utils/phone_field_controller.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'user_information_logic.dart';
part 'user_information_page_design_logic.dart';

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State<UserInformationPage> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController maidenNameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  dynamic _emailValidationMessage;
  late PhoneFieldController phoneNumberController = PhoneFieldController(
    textController: TextEditingController(),
  );
  bool isCheckingPhoneNumber = false;

  bool? validPhoneNumber;
  List<String> titlesList = ['Mr.', 'Mrs.', 'Miss', 'Ms.'];
  String? selectedTitle;
  String? dateOfBirth;
  User? user;

  dateOfBirthCallBack(String date) => setState(() => dateOfBirth = date);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => initializeData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Applicant Information',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Title:'),
                  const SizedBox(width: 10),
                  Container(
                    width: 99,
                    child: dropDownField(
                        list: titlesList,
                        onChanged: (title) =>
                            setState(() => selectedTitle = title)),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textField(
                        label: 'First Name', controller: firstNameController),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textField(
                        label: "Father's Name",
                        controller: fatherNameController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textField(
                        label: 'Maiden Name', controller: maidenNameController),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textField(
                        label: " Family Name",
                        controller: familyNameController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: datePicker(
                        context: context,
                        label: 'Date of Birth',
                        callCalendarBack: dateOfBirthCallBack,
                        chosenDate: dateOfBirth,
                        lastDate: DateTime.now()),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textField(
                        label: "Place of Birth",
                        controller: placeOfBirthController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textField(
                        label: "Nationality",
                        controller: nationalityController),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textField(
                        label: "Occupation", controller: occupationController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(120, 120, 120, 0.24),
                          border: Border.all(
                            color: validPhoneNumber == null ||
                                    validPhoneNumber == true
                                ? Colors.transparent
                                : Colors.red,
                          ),
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
                              ),
                              width: 50,
                              height: 60,
                              child: const Center(child: Text('+961')),
                            ),
                            Expanded(
                              child: TextField(
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
                                                  scale: 1.8,
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
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) checkEmail();
                    },
                    child: TextFormField(
                      controller: emailController,
                      onChanged: (s) => setState(() {
                        emailController = emailController;
                      }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => _emailValidationMessage,
                      textInputAction: TextInputAction.next,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: 'Email',
                          floatingLabelStyle:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          labelStyle:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 0),
                          ),
                          errorBorder: errorBorder(),
                          focusedErrorBorder: errorBorder()),
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 50),
              Center(
                  child: ElevatedButton(
                      onPressed: onEditInfo, child: Text('Submit')))
            ],
          ),
        ),
      ),
    );
  }
}
