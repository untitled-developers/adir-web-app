import 'package:flutter/material.dart';

Widget helloImLisaWidget() {
  return const Center(
    child: Column(
      children: [
        Text(
          'Hello',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        Text("I'm Lisa,"),
        SizedBox(height: 50)
      ],
    ),
  );
}
