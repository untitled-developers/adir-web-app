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
          const Expanded(
            child: Text(
                'In case you choose Motor All Risks, your total value will be: '),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Text('${allRisksValue.toString()}\$',
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 18)),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const Expanded(
            child: Text(
                'In case you choose Motor All Risks Plus, your total value will be: '),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Text('${allRisksPlusValue.toString()}\$',
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 18)),
          ),
        ],
      ),
      const SizedBox(height: 40),
      Text(text),
      const SizedBox(height: 10),
      ElevatedButton(onPressed: onButtonTap, child: const Text('Yes'))
    ],
  );
}
