part of 'questions_page.dart';

extension QuestionsPageDesignLogic on _QuestionsPageState {
  void _nextQuestion() {
    currentController = TextEditingController();

    currentController.text = currentQuestion['answer'].toString();

    Provider.of<PrefsData>(context, listen: false)
        .updateAnswer(currentQuestionKey, currentQuestion['answer']);
    print(
        'Answer::::: ${Provider.of<PrefsData>(context, listen: false).questions[currentQuestionKey]['answer']}');
    if (currentQuestionKey == 'natureofvehicle') {
      checkNatureOfVehicleAnswer();
    } else if (currentQuestionKey == 'insurancetype') {
      checkInsuranceTypeAnswer();
    } else if (currentQuestionKey == 'yearofmake') {
      checkYearOfMakeGap();
    }
    setState(() {
      if (currentIndex < keys!.length - 1) {
        currentIndex++;
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DonePage()));
      }
    });
  }

  void _previousQuestion() {
    setState(() => enableSelection = true);
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }
}
