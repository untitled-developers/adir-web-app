part of 'questions_page.dart';

extension QuestionsPageDesignLogic on _QuestionsPageState {
  void _nextQuestion() {
    Provider.of<PrefsData>(context, listen: false)
        .updateAnswer(currentQuestionKey, currentQuestion['answer']);
    if (currentIndex == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
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
