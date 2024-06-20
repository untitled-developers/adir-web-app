import 'package:adir_web_app/utils/calculate_payment_value.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget footerWidget(BuildContext context, String text, Function() onButtonTap) {
  int yearOfMake = int.parse(Provider.of<PrefsData>(context, listen: false)
      .questions['yearofmake']['answer']
      .toString());
  double carValue = double.parse(Provider.of<PrefsData>(context, listen: false)
      .questions['carvalue']['answer']
      .toString());
  double allRisksValue = getAllRisksPaymentValue(yearOfMake, carValue);
  double allRisksPlusValue = getAllRisksPlusPaymentValue(yearOfMake, carValue);
  return Column(
    children: [
      Row(
        children: [
          Text(
              'In case you choose Motor All Risks, your total value will be: '),
          Text('${allRisksValue.toString()}\$',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Text(
              'In case you choose Motor All Risks Plus, your total value will be: '),
          Text('${allRisksPlusValue.toString()}\$',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
        ],
      ),
      const SizedBox(height: 40),
      Text(text),
      const SizedBox(height: 10),
      ElevatedButton(onPressed: onButtonTap, child: const Text('Yes'))
    ],
  );
}
