part of 'questions_page.dart';

extension QuestionsPageDesignLogic on _QuestionsPageState {
  void _nextQuestion() {
    Provider.of<PrefsData>(context, listen: false)
        .updateAnswer(currentQuestionKey, currentQuestion['answer']);
    print(
        'Saved map: ${Provider.of<PrefsData>(context, listen: false).questions}');
    if (currentIndex == 0 || currentIndex == 1 || currentIndex == 2) {
      validateRequiredQuestions();
      return;
    }
    submitQuestions();

    if (currentIndex == 7 && currentQuestion['answer'] == 'Fresh Card') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LinkToPaymentGatewayPage()));
    } else if (currentIndex == 8) {
      RegExp emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (emailValid.hasMatch(currentController.text) == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DonePage()));
      }
    } else {
      setState(() {
        if (currentIndex < keys!.length - 1) {
          if (currentIndex != 5) {
            currentIndex++;
          } else if (currentIndex == 5) {
            _formKey.currentState!.validate();
            if (currentController.text.isNotEmpty ||
                nextController.text.isNotEmpty) currentIndex = currentIndex + 2;
          }
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DonePage()));
        }
      });
    }
    currentController = TextEditingController();
  }

  void _previousQuestion() {
    setState(() => enableSelection = true);
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        if (currentIndex == 6) currentIndex--;
      }
    });
  }
}
