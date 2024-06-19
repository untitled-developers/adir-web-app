import 'package:adir_web_app/login/login_page.dart';
import 'package:adir_web_app/pages/link_to_payment_gateway_page.dart';
import 'package:adir_web_app/pages/questions_page/case_others/case_others_page.dart';
import 'package:adir_web_app/pages/questions_page/done_page.dart';
import 'package:adir_web_app/pages/questions_page/widgets/covers_info_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/description_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/footer_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/hello_im_lisa_widget.dart';
import 'package:adir_web_app/pages/questions_page/widgets/question_content_widget.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
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
  List<String>? keys;
  TextEditingController currentController = TextEditingController();
  TextEditingController nextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _emailValidationMessage;
  Map<String, dynamic>? allQuestions;
  String? chosenYearOfMake = '2024';
  bool enableSelection = true;
  int yearOfMakeGap = 0;
  var currentQuestionKey;
  var currentQuestion;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => initializeData());
  }

  @override
  Widget build(BuildContext context) {
    currentQuestionKey = keys?[currentIndex] ?? '';
    currentQuestion = allQuestions?[currentQuestionKey] ?? '';
    dynamic nextQuestion;
    currentController = TextEditingController();
    if (currentQuestionKey == 'registrationnumber') {
      nextQuestion = allQuestions?[keys?[currentIndex + 1]] ?? '';
    }

    if (currentQuestion != null && currentQuestion.isNotEmpty) {
      setState(() {
        currentController.text = currentQuestion['answer'].toString();
        if (currentQuestionKey == 'registrationnumber') {
          nextController.text = nextQuestion['answer'].toString();
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description of the Risk'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  questionContentWidget(
                                      context, currentQuestion, setState,
                                      controller: currentController,
                                      chosenYear: chosenYearOfMake,
                                      enabled: enableSelection,
                                      callCalendarBack: yearOfMakeCallBack),
                                  const SizedBox(height: 50),
                                  Text(
                                    nextQuestion['languages']['EN'],
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(height: 20),
                                  questionContentWidget(
                                      context, nextQuestion, setState,
                                      controller: nextController,
                                      chosenYear: chosenYearOfMake,
                                      enabled: enableSelection,
                                      callCalendarBack: yearOfMakeCallBack),
                                  const SizedBox(height: 50),
                                ],
                              )
                            : questionContentWidget(
                                context, currentQuestion, setState,
                                controller: currentController,
                                chosenYear: chosenYearOfMake,
                                enabled: enableSelection,
                                callCalendarBack: yearOfMakeCallBack),
                        const SizedBox(height: 20),
                        if (currentQuestionKey == 'insurancetype')
                          footerWidget(
                              'Do you want to know more about the covers & benefits of each option?',
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CoversInfoWidget()));
                          }),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: [
                                TextButton(
                                  onPressed: _previousQuestion,
                                  child: const Text('Back'),
                                ),
                                const SizedBox(width: 50),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white),
                                  onPressed: _nextQuestion,
                                  child: const Text('Next'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
