import 'package:adir_web_app/api/session.dart';
import 'package:adir_web_app/login/login_page.dart';
import 'package:adir_web_app/main.dart';
import 'package:adir_web_app/pages/link_to_payment_gateway_page.dart';
import 'package:adir_web_app/pages/questions_page/case_others/case_others_page.dart';
import 'package:adir_web_app/pages/questions_page/done_page.dart';
import 'package:adir_web_app/pages/questions_page/widgets/covers_info_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/description_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/footer_buttons.dart';
import 'package:adir_web_app/pages/questions_page/widgets/footer_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/hello_im_lisa_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/question_content_widget.dart';
import 'package:adir_web_app/utils/dialog_utils.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'questions_page_design_logic.dart';
part 'questions_page_logic.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, this.index});

  final int? index;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int currentIndex = 0;
  bool isLoading = true;
  bool showValidationMessage = false;
  List<String>? keys;
  TextEditingController currentController = TextEditingController();
  TextEditingController nextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic>? localQuestions;

  String? chosenYearOfMake = '2024';
  bool enableSelection = true;
  int yearOfMakeGap = 0;
  late String currentQuestionKey;
  late String nextQuestionKey;
  var currentQuestion;
  dynamic nextQuestion;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => initializeData());
  }

  @override
  void dispose() {
    currentController.dispose();
    nextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentQuestionKey = keys?[currentIndex] ?? '';
    nextQuestionKey = currentQuestionKey == 'registrationnumber'
        ? keys![currentIndex + 1]
        : '';
    Map<String, dynamic> localQuestion =
        Map.from(localQuestions?[currentQuestionKey] ?? {});
    currentQuestion = localQuestion;
    if (currentQuestionKey == 'registrationnumber') {
      Map<String, dynamic> nextLocalQuestion =
          Map.from(localQuestions?[nextQuestionKey] ?? {});
      nextQuestion = nextLocalQuestion;
    }
    fillControllerText();
    return Scaffold(
      backgroundColor: Color.fromRGBO(159, 129, 187, 1),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 500),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(height: 150),
                                helloImLisaWidget(),
                                descriptionWidget(context, currentIndex),
                                const SizedBox(height: 50),
                                Text(
                                  currentQuestion['languages']['EN'],
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 20),
                                currentQuestionKey == 'registrationnumber'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          questionContentWidget(
                                            context,
                                            currentQuestion,
                                            controller: currentController,
                                            chosenYear: chosenYearOfMake,
                                          ),
                                          const SizedBox(height: 50),
                                          Text(
                                            nextQuestion['languages']['EN'],
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(height: 20),
                                          questionContentWidget(
                                            context,
                                            nextQuestion,
                                            controller: nextController,
                                            chosenYear: chosenYearOfMake,
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      )
                                    : questionContentWidget(
                                        context, currentQuestion,
                                        controller: currentController,
                                        chosenYear: chosenYearOfMake,
                                        key: currentQuestionKey),
                                const SizedBox(height: 20),
                                if (currentQuestionKey == 'insurancetype')
                                  footerWidget(context,
                                      'Do you want to know more about the covers & benefits of each option?',
                                      () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                CoversInfoWidget(),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero));
                                  }),
                                if (showValidationMessage)
                                  const Text(
                                    'This question is required.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        if (currentIndex != 0 &&
                                            currentIndex != 3)
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.black),
                                            onPressed: _previousQuestion,
                                            child: const Text('Back'),
                                          ),
                                        const SizedBox(width: 50),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.yellow,
                                              foregroundColor: Colors.black),
                                          onPressed: _nextQuestion,
                                          child: const Text('Next'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                footerButtons(context,
                    currentIndex == 0 || currentIndex == 1 || currentIndex == 2)
              ],
            ),
    );
  }
}
