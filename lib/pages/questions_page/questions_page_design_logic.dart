part of 'questions_page.dart';

extension QuestionsPageDesignLogic on _QuestionsPageState {
  void _nextQuestion() {
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
