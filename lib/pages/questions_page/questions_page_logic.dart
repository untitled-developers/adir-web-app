part of 'questions_page.dart';

extension QuestionsPageLogic on _QuestionsPageState {
  initializeData() async {
    if (widget.index != null) {
      currentIndex = widget.index!;
    }

    localQuestions = {};
    localQuestions?.addAll(
      Map.fromEntries(
        Provider.of<PrefsData>(context, listen: false).questions.entries.map(
              (entry) => MapEntry(
                entry.key,
                entry.value,
              ),
            ),
      ),
    );
    keys = localQuestions?.keys.toList();
    setState(() => isLoading = false);
  }

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

  checkIfFormComplete() {
    if (Provider.of<PrefsData>(context, listen: false)
            .getFormFinishedPercentage() ==
        100) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DonePage()),
      );
    } else {
      DialogUtils.showNotifyDialog(
        context,
        actions: TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('Okay')),
        body: Text(
            'Your form is still incomplete, please answer all the questions.'),
      );
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
    String oldAnswer = Provider.of<PrefsData>(context, listen: false)
        .questions[currentQuestionKey]['answer']
        .toString();
    Provider.of<PrefsData>(context, listen: false)
        .updateAnswer(currentQuestionKey, currentQuestion['answer']);

    Map<String, dynamic> data = {
      "version": 1,
      "is_draft": true,
      "question_key": currentQuestionKey.toString(),
      "answer_old_value": oldAnswer.toString(),
      "answer_new_value": localQuestions![currentQuestionKey].toString(),
      "form_finished_percentage": Provider.of<PrefsData>(context, listen: false)
          .getFormFinishedPercentage(),
      "payload": localQuestions,
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
