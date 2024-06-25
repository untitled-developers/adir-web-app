import 'package:adir_web_app/common/widgets/textField.dart';
import 'package:flutter/material.dart';

//TODO remove enabled if sure we dont need it any more
Widget questionContentWidget(
    BuildContext context, Map<String, dynamic> question,
    {TextEditingController? controller,
    String? chosenYear,
    bool? enabled,
    bool? isValid,
    String? key}) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
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
              value: question['answer'].toString() == '1',
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
          onChanged: (value) {
            question['answer'] = double.tryParse(value) ?? '';
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
        controller: controller,
        // onChanged: (value) {
        //   setState(() {
        //     question['answer'] = int.tryParse(value) ?? '';
        //   });
        // }
      );
    } else if (question['value'] == 'string') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            RegExp emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
            if (emailValid.hasMatch(controller!.text) == false) {
              return 'Invalid Email';
            }
            question['answer'] = value;
            return null;
          },
          textInputAction: TextInputAction.next,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              filled: true,
              labelText: 'Email',
              floatingLabelStyle:
                  const TextStyle(fontSize: 12, color: Colors.grey),
              labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary, width: 1),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              errorBorder: errorBorder(),
              focusedErrorBorder: errorBorder()),
        ),
      );
    }
    return Container();
  });
}

OutlineInputBorder errorBorder() => const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderSide: BorderSide(color: Colors.red, width: 1),
    );
