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

  submitQuestions() {
    Map<String, dynamic> data = {
      "version": 1,
      "is_draft": 1,
      "form_finished_percentage": Provider.of<PrefsData>(context, listen: false)
          .getFormFinishedPercentage(),
      "payload": allQuestions,
    };

    Session()
        .apiClient
        .submissionsAPI
        .submitQuestions(data)
        .catchError((error, stack) {
      logger.e('Error', error: error, stackTrace: stack);
      if (mounted) {
        if (error is DioException && error.response != null) {
          DialogUtils.showErrorDialog(
            context,
            body: Text(
              error.response!.data['message'],
            ),
          );
        } else {
          DialogUtils.showErrorDialog(
            context,
            body: const Text("Error while saving data."),
          );
        }
      }
    });
  }
}
