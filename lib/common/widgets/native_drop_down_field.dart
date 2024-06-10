import 'package:flutter/material.dart';

Widget dropDownField(
    {required List<dynamic> list,
    required dynamic selectedItem,
    required Function(dynamic) onChanged,
    bool? valid,
    bool? enabled,
    double? radius,
    String? errorText}) {
  if (selectedItem != null && !list.contains(selectedItem)) {
    selectedItem = null;
  }
  return Material(
    color: Colors.transparent,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: valid == null || valid == true
                  ? const Color.fromRGBO(230, 230, 230, 1)
                  : Colors.red),
          borderRadius: BorderRadius.circular(radius ?? 4),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: DropdownButtonFormField<dynamic>(
              value: selectedItem,
              decoration: const InputDecoration(border: InputBorder.none),
              items: list.map<DropdownMenuItem<dynamic>>((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (dynamic value) => onChanged(value),
            )),
      ),
      if (valid != null && !valid) ...[
        const SizedBox(height: 4),
        Text(
          errorText != null ? ' $errorText' : '',
          style: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ]
    ]),
  );
}
