import 'package:adir_web_app/common/widgets/date_picker_widget.dart';
import 'package:adir_web_app/common/widgets/textField.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

//TODO Fix this
//TODO Handle case of int
Widget questionContentWidget(BuildContext context,
    Map<String, dynamic> question, Function(void Function()) setState,
    {TextEditingController? controller,
    String? chosenYear,
    Function? callCalendarBack}) {
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
            value: question['answer'] == 1,
            onChanged: (value) {
              setState(() {
                question['answer'] = value ? 1 : 0;
              });
            },
          ),
        ),
        Text('Yes'),
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
          });
        },
        inputType: TextInputType.number);
  } else if (question['languages']['EN'] == 'Year of Make') {
    return datePicker(
        context: context,
        label: 'Choose a year',
        chosenDate: chosenYear,
        calendarViewMode: CalendarDatePicker2Mode.year,
        callCalendarBack: callCalendarBack!);
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
