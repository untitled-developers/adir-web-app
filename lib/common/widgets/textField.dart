import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textField(
    {required String label,
    required TextEditingController controller,
    String? errorMessage,
    TextInputType? inputType,
    bool? isDigitsOnly,
    Widget? suffixIcon,
    bool? enabled,
    Function(String)? onChanged,
    bool? shouldValidate,
    bool? isValid}) {
  return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
    return TextFormField(
      autovalidateMode: isValid != null && !isValid
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      keyboardType: inputType ?? TextInputType.text,
      inputFormatters: isDigitsOnly == true
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      validator: (value) {
        if ((value == null || value.isEmpty)) {
          return "Can't be empty";
        } else if (errorMessage != null) {
          return errorMessage;
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      enabled: enabled ?? true,
      controller: controller,
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
