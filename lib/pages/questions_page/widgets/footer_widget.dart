import 'package:flutter/material.dart';

Widget footerWidget(String text, Function() onButtonTap) {
  return Column(
    children: [
      Text(text),
      const SizedBox(height: 10),
      ElevatedButton(onPressed: onButtonTap, child: const Text('Yes'))
    ],
  );
}
