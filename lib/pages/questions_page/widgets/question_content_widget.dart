import 'package:flutter/material.dart';

//TODO Fix this
Widget questionContentWidget(
    Map<String, dynamic> question, Function(void Function()) setState) {
  if (question['value'] is List) {
    return Column(
      children: (question['value'] as List<dynamic>)
          .map((option) => ListTile(
                title: Text(option),
                leading: Radio(
                  value: option,
                  groupValue: question['answer'],
                  onChanged: (value) {
                    setState(() {
                      question['answer'] = value;
                    });
                  },
                ),
              ))
          .toList(),
    );
  } else if (question['value'] == 'bool') {
    return Row(
      children: [
        Text('No'),
        Container(
          width: 120,
          child: SwitchListTile(
            value: question['answer'] == 'Yes',
            onChanged: (value) {
              setState(() {
                question['answer'] = value ? 'Yes' : 'No';
              });
            },
          ),
        ),
        Text('Yes'),
      ],
    );
  } else if (question['value'] == 'double') {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Enter value'),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          question['answer'] = double.tryParse(value) ?? '';
        });
      },
    );
  } else if (question['value'] == 'int') {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Enter value'),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          question['answer'] = int.tryParse(value) ?? '';
        });
      },
    );
  }
  return Container();
}
