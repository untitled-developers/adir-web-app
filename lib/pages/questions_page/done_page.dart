import 'package:adir_web_app/pages/motor_insurance_page.dart';
import 'package:adir_web_app/utils/calculate_payment_value.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  double totalPaymentValue = 0;
  bool isLoading = true;

  //TODO Save payment value in provider if necessary

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool elzemeh = Provider.of<PrefsData>(context, listen: false)
              .questions['elzemeh']['answer']
              .toString() ==
          '1';
      int yearOfMake = int.parse(Provider.of<PrefsData>(context, listen: false)
          .questions['yearofmake']['answer']
          .toString());
      double carValue = double.parse(
          Provider.of<PrefsData>(context, listen: false)
              .questions['carvalue']['answer']
              .toString());
      bool isAllRisks = Provider.of<PrefsData>(context, listen: false)
              .questions['insurancetype']['answer']
              .toString() ==
          'Motor All Risks';
      totalPaymentValue = isAllRisks
          ? getAllRisksPaymentValue(yearOfMake, carValue)
          : getAllRisksPlusPaymentValue(yearOfMake, carValue);
      if (elzemeh) setState(() => totalPaymentValue += 30);
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Done'),
                  SizedBox(height: 50),
                  Text(
                      'Your total payment value will be: $totalPaymentValue\$'),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                MotorInsurancePage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero)),
                    child: Text('Proceed to Motor Insurance Page'),
                  )
                ],
              ),
            ),
          );
  }
}
