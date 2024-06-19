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
    currentController.addListener(() => setState(() {}));

    setState(() => isLoading = false);
  }

  yearOfMakeCallBack(String date) => setState(() => chosenYearOfMake = date);
}
