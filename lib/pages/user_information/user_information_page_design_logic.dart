part of 'user_information_page.dart';

extension UserInformationPageDesignLogic on _UserInformationPageState {
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

  OutlineInputBorder errorBorder() => const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Colors.red, width: 1),
      );

  checkEmail() {
    _emailValidationMessage = null;
    setState(() {});
    RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (emailValid.hasMatch(emailController.text) == false) {
      _emailValidationMessage = 'Invalid Email';

      if (mounted) {
        setState(() {});
      }
    }
  }

  onEditInfo() {
    _formKey.currentState?.validate();
    if (isFormComplete()) {
      Map<String, dynamic> data = {
        "title": selectedTitle ?? '',
        "first_name": firstNameController.text,
        "father_name": fatherNameController.text,
        "maiden_name": maidenNameController.text,
        "family_name": familyNameController.text,
        "nationality": nationalityController.text,
        "email": emailController.text,
        "occupation": occupationController.text,
        "date_of_birth":
            DateFormat('yyyy-MM-dd').format(DateTime.parse(dateOfBirth!)),
        "place_of_birth": placeOfBirthController.text,
        "applicant_phone": phoneNumberController.textController.text,
      };
      DialogUtils.showProgressDialog(context);
      Session().apiClient.usersAPI.updateUserInfo(data).then((response) {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() => isEditing = false);
        DialogUtils.showNotifyDialog(context, body: Text('Done'));
      }).catchError((error, stack) {
        logger.e('Error', error: error, stackTrace: stack);
        if (mounted) {
          if (error is DioException && error.response != null) {
            DialogUtils.showErrorDialog(
              context,
              body: Text(
                error.response!.data['message'],
              ),
            );
          } else {
            DialogUtils.showErrorDialog(
              context,
              body: const Text("Error while editing info."),
            );
          }
        }
      });
    }
  }
  onProceed ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> QuestionsPage()));
}
