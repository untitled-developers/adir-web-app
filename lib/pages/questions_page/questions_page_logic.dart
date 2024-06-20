part of 'questions_page.dart';

extension QuestionsPageLogic on _QuestionsPageState {
  initializeData() async {
    if (widget.index != null) {
      currentIndex = widget.index!;
    }
    allQuestions = {};
    allQuestions
        ?.addAll(Provider.of<PrefsData>(context, listen: false).questions);
    keys = allQuestions?.keys.toList();

    setState(() => isLoading = false);
  }

//TODO Remove this
  yearOfMakeCallBack(String date) => setState(() => chosenYearOfMake = date);

  validateRequiredQuestions() {
    if (currentQuestion['answer'] == null ||
        currentQuestion['answer'].toString().isEmpty) {
      setState(() => showValidationMessage = true);
    } else {
      setState(() => showValidationMessage = false);
      if (currentIndex == 0 && currentQuestion['answer'] == 'Other') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CaseOthersPage()));
      } else if (currentIndex == 2) {
        int yearOfMake = int.parse(
            Provider.of<PrefsData>(context, listen: false)
                .questions['yearofmake']['answer']
                .toString());
        double carValue = double.parse(
            Provider.of<PrefsData>(context, listen: false)
                .questions['carvalue']['answer']
                .toString());
        double value = getAllRisksPaymentValue(yearOfMake, carValue);
        print('testtt $value');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
      currentIndex++;
    }
  }

  fillControllerText() {
    if (currentQuestion != null && currentQuestion.isNotEmpty) {
      currentController.text = currentQuestion['answer'].toString();
      if (currentQuestionKey == 'registrationnumber') {
        nextController.text = nextQuestion['answer'].toString();
      }
    }
  }
}
