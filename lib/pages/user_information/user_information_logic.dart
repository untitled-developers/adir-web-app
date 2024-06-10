part of 'user_information_page.dart';

extension UserInformationLogic on _UserInformationPageState {
  initializeData() {
    user = Provider.of<PrefsData>(context, listen: false).user;
    if (user != null) {
      selectedTitle = user!.title;
      firstNameController.text = user!.firstName ?? '';
      fatherNameController.text = user!.fatherName ?? '';
      maidenNameController.text = user!.maidenName ?? '';
      familyNameController.text = user!.familyName ?? '';
      nationalityController.text = user!.nationality ?? '';
      emailController.text = user!.email ?? '';
      occupationController.text = user!.occupation ?? '';
      dateOfBirth =
          user!.dateOfBirth != null ? user!.dateOfBirth.toString() : '';
      placeOfBirthController.text = user!.placeOfBirth ?? '';
      phoneNumberController.textController.text = user!.applicantPhone ?? '';
    }
    setState(() {});
  }
}
