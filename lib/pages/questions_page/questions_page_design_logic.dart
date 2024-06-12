part of 'questions_page.dart';

extension QuestionsPageDesignLogic on _QuestionsPageState {
  void _nextQuestion() {
    currentController = TextEditingController();
    Provider.of<PrefsData>(context, listen: false)
        .updateAnswer(currentQuestionKey, currentQuestion['answer']);
    if (currentQuestionKey == 'natureofvehicle') {
      checkNatureOfVehicleAnswer();
    } else if (currentQuestionKey == 'insurancetype') {
      checkInsuranceTypeAnswer();
    }
    setState(() {
      if (currentIndex < keys!.length - 1) {
        currentIndex++;
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }
}
