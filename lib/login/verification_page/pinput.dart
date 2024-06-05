part of 'verification_page.dart';

final defaultPinTheme = PinTheme(
  width: 54,
  height: 54,
  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  decoration: BoxDecoration(
      border: Border.all(color: Colors.blueGrey),
      borderRadius: BorderRadius.circular(50),
      color: Colors.white),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    borderRadius: BorderRadius.circular(50), color: Colors.white);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    border: Border.all(color: Colors.black),
  ),
);

// ignore: library_private_types_in_public_api
extension PinPutCode on _VerificationPageState {

  Widget pinPutWidget(){
   return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      controller: _pinPutController,

      validator: (value) => validatePin(value),
      // androidSmsAutofillMethod:
      //     AndroidSmsAutofillMethod.smsUserConsentApi,
      onSubmitted: (String pin) =>
      validPin ? _verifySMSCode(pin) : {},
      onCompleted: (String pin) =>
      validPin ? _verifySMSCode(pin) : {},
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
    );

  }
}
