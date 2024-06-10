import 'package:flutter/material.dart';

Widget textField(
    {required String label,
    required TextEditingController controller,
    String? errorMessage,
    TextInputType? inputType,
    Widget? suffixIcon,
    bool? enabled,
    bool? isValid}) {
  return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      autovalidateMode: isValid != null && !isValid
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Can't be empty";
        } else if (errorMessage != null) {
          return errorMessage;
        } else {
          return null;
        }
      },
      enabled: enabled ?? true,
      controller: controller,
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        suffixText: label == 'Weight' ? 'KG' : '',
        suffixIcon: suffixIcon ?? SizedBox(),
        label: Text(label),
        hintText: label == 'Card Number' ? 'xxxx - xxxx - xxxx - xxxx' : '',
        hintStyle: TextStyle(color: Colors.grey),
        floatingLabelStyle: TextStyle(fontSize: 12, color: Colors.grey),
        labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 1),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  });
}
