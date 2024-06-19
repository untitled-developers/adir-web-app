import 'package:adir_web_app/common/widgets/textField.dart';
import 'package:adir_web_app/pages/questions_page/done_page.dart';
import 'package:adir_web_app/pages/questions_page/widgets/hello_im_lisa_widget.dart';
import 'package:adir_web_app/utils/phone_field_controller.dart';
import 'package:flutter/material.dart';

part 'case_others_design_logic.dart';

class CaseOthersPage extends StatefulWidget {
  const CaseOthersPage({super.key});

  @override
  State<CaseOthersPage> createState() => _CaseOthersPageState();
}

class _CaseOthersPageState extends State<CaseOthersPage> {
  TextEditingController nameController = TextEditingController();
  late PhoneFieldController phoneNumberController = PhoneFieldController(
    textController: TextEditingController(),
  );
  bool isCheckingPhoneNumber = false;
  bool? validPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            helloImLisaWidget(),
            const SizedBox(height: 100),
            Text("We're sorry you couldn’t find your car to insure it,"),
            const SizedBox(height: 20),
            Text('Leave your number here & we will call you'),
            const SizedBox(height: 50),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: textField(
                  label: 'First Name',
                  controller: nameController,
                  enabled: true,
                )),
            const SizedBox(height: 20),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: validPhoneNumber == null || validPhoneNumber == true
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
                      child: TextField(
                          controller: phoneNumberController.textController,
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
                                    child: const CircularProgressIndicator())
                                : validPhoneNumber == true
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Image.asset(
                                          'assets/icons/tick.png',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    : null,
                            counter: const Offstage(),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
            TextButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      validPhoneNumber == true)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DonePage()));
                },
                child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
