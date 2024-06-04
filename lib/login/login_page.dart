import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Adir Web Application',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        // color: validPhoneNumber
                        //     ? Theme.of(context).colorScheme.secondary
                        //     : Colors.red,
                        ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                            //TODO Add controller here
                            controller: TextEditingController(),
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.black),
                            cursorHeight: 20,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: const InputDecoration(
                              counter: Offstage(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              labelStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              labelText: 'Phone Number',
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  )),
              const SizedBox(height: 30),
              SizedBox(
                width: double.maxFinite,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(height: 42),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ]),
      ),
    );
  }
}
