part of 'questions_page.dart';

extension QuestionsPageLogic on _QuestionsPageState {
  initializeData() async {
    allQuestions = Provider.of<PrefsData>(context, listen: false).questions;
    keys = allQuestions!.keys.toList();
    setState(() => isLoading = false);
  }

  yearOfMakeCallBack(String date) => setState(() => chosenYearOfMake = date);

  checkQuestionAnswer() {
    if (Provider.of<PrefsData>(context, listen: false)
        .questions['natureofvehicle']['answer']
        .isNotEmpty) {
      var carBrandQuestion =
          Provider.of<PrefsData>(context, listen: false).questions['carbrand'];
      var answer = Provider.of<PrefsData>(context, listen: false)
              .questions['natureofvehicle']['answer'] ??
          '';
      if (answer != 'Private Car') {
        keys!.removeWhere((element) => element == 'carbrand');
        allQuestions!.removeWhere((key, value) => key == 'carbrand');
        Provider.of<PrefsData>(context, listen: false)
            .updateAnswer('carbrand', '');
      } else {
        if (!allQuestions!.containsKey('carbrand')) {
          allQuestions!.addAll(carBrandQuestion);
        }
      }
    }
  }
}
