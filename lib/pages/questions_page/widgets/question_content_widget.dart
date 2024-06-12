import 'package:adir_web_app/common/widgets/textField.dart';
import 'package:flutter/material.dart';

//TODO Fix this
//TODO Handle case of int
Widget questionContentWidget(BuildContext context,
    Map<String, dynamic> question, Function(void Function()) setState,
    {TextEditingController? controller,
    String? chosenYear,
    bool? enabled,
    Function? callCalendarBack}) {
  if (question['value'] is List) {
    return Column(
      children: (question['value'] as List<dynamic>)
          .map((option) => ListTile(
                enabled: enabled ?? true,
                title: Text(option),
                leading: Radio(
                  value: option,
                  toggleable: enabled ?? true,
                  groupValue: question['answer'],
                  onChanged: (value) {
                    enabled == false
                        ? {}
                        : setState(() {
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
        const Text('No'),
        Container(
          width: 120,
          child: SwitchListTile(
            value: question['answer'] == 1,
            onChanged: (value) {
              setState(() {
                question['answer'] = value ? 1 : 0;
              });
            },
          ),
        ),
        const Text('Yes'),
      ],
    );
  } else if (question['value'] == 'double') {
    return textField(
        label: 'Enter Value',
        controller: controller!,
        isValid: true,
        onChanged: (value) {
          setState(() {
            question['answer'] = double.tryParse(value) ?? '';
            print('testtt here ${question['answer'].toString()}');
          });
        },
        inputType: TextInputType.number);
  } else if (question['languages']['EN'] == 'Year of Make') {
    return TextField(
        controller: controller,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'Select Year',
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          int? selectedYear = await showDialog<int>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Select Year'),
                content: Container(
                  height: 300,
                  width: 300,
                  child: YearPicker(
                    firstDate: DateTime(2000),
                    lastDate: DateTime(DateTime.now().year),
                    selectedDate: DateTime.now(),
                    onChanged: (DateTime dateTime) {
                      question['answer'] = dateTime.year.toString();
                      controller!.text = question['answer'].toString();
                      Navigator.pop(context, dateTime.year);
                    },
                  ),
                ),
              );
            },
          );

          if (selectedYear != null) {
            setState(() {
              controller!.text = selectedYear.toString();
            });
          }
        });
  } else if (question['value'] == 'int') {
    return TextFormField(
        decoration: const InputDecoration(labelText: 'Enter value'),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            question['answer'] = int.tryParse(value) ?? '';
          });
        });
  }
  return Container();
}
