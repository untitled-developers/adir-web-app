import 'package:adir_web_app/pages/motor_insurance_page.dart';
import 'package:flutter/material.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Done'),
            SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MotorInsurancePage())),
              child: Text('Proceed to Motor Insurance Page'),
            )
          ],
        ),
      ),
    );
  }
}
