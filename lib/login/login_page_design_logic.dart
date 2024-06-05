part of 'login_page.dart';

extension LoginPageDesignLogic on _LoginPageState {
  onLogIn() {}

  onMobileTextChange(text) async {
    isCheckingPhoneNumber =
        phoneNumberController.textController.text.isNotEmpty;
    validPhoneNumber = phoneNumberController.textController.text.isNotEmpty
        ? await phoneNumberController.phoneNumberValid()
        : false;
    if (validPhoneNumber == true) isCheckingPhoneNumber = false;
    setState(() {});
  }

  onEditingComplete() => setState(() => isCheckingPhoneNumber = false);
}
