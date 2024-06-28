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
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    CaseOthersPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      } else if (currentIndex == 2) {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => LoginPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      }
      if (currentIndex != 2) currentIndex++;
    }
  }

  checkIfFormComplete() {
    if (Provider.of<PrefsData>(context, listen: false)
            .getFormFinishedPercentage() ==
        100) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => DonePage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero));
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
    if (currentQuestion['answer'] !=
        Provider.of<PrefsData>(context, listen: false)
            .questions[currentQuestionKey]['answer']) {
      String oldAnswer = Provider.of<PrefsData>(context, listen: false)
          .questions[currentQuestionKey]['answer']
          .toString();
      submitRequest(currentQuestionKey.toString(), oldAnswer.toString(),
          currentQuestion['answer'].toString());
    }
    if (currentQuestionKey == 'registrationnumber' &&
        nextQuestion['answer'] !=
            Provider.of<PrefsData>(context, listen: false)
                .questions[nextQuestionKey]['answer']) {
      String oldAnswer = Provider.of<PrefsData>(context, listen: false)
          .questions[nextQuestionKey]['answer']
          .toString();

      submitRequest(nextQuestionKey.toString(), oldAnswer.toString(),
          nextQuestion['answer'].toString());
    }
  }

  submitRequest(String questionKey, String oldAnswer, String newAnswer) {
    Provider.of<PrefsData>(context, listen: false)
        .updateAnswer(questionKey, newAnswer);
    Map<String, dynamic> data = {
      "version": 1,
      "is_draft": true,
      "question_key": questionKey,
      "answer_old_value": oldAnswer,
      "answer_new_value": newAnswer.isNotEmpty ? newAnswer : null,
      "form_finished_percentage": Provider.of<PrefsData>(context, listen: false)
          .getFormFinishedPercentage(),
      "payload": localQuestions,
    };
    print('Data: $data');
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
