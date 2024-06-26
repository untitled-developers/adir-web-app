part of 'questions_page.dart';

extension QuestionsPageDesignLogic on _QuestionsPageState {
  void _nextQuestion() {
    if (currentIndex == 0 || currentIndex == 1 || currentIndex == 2) {
      Provider.of<PrefsData>(context, listen: false)
          .updateAnswer(currentQuestionKey, currentQuestion['answer']);
      validateRequiredQuestions();
      return;
    }

    submitQuestions();

    if (currentIndex == 7 && currentQuestion['answer'] == 'Fresh Card') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  LinkToPaymentGatewayPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero));
    } else if (currentIndex == 8) {
      RegExp emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (emailValid.hasMatch(currentController.text) == true) {
        checkIfFormComplete();
      }
    } else {
      setState(() {
        if (currentIndex < keys!.length - 1) {
          if (currentIndex != 5) {
            currentIndex++;
          } else if (currentIndex == 5) {
            _formKey.currentState!.validate();
            if (currentController.text.isNotEmpty ||
                nextController.text.isNotEmpty) {
              currentIndex = currentIndex + 2;
            }
          }
        } else {
          checkIfFormComplete();
        }
      });
    }

    currentController = TextEditingController();
  }

  void _previousQuestion() {
    showValidationMessage = false;

    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        if (currentIndex == 6) currentIndex--;
      }
    });
  }
}
