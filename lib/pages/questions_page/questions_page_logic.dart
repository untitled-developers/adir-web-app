part of 'questions_page.dart';

extension QuestionsPageLogic on _QuestionsPageState {
  initializeData() async {
    allQuestions = Provider.of<PrefsData>(context, listen: false).questions;
    keys = allQuestions!.keys.toList();
    setState(() => isLoading = false);
  }
}
