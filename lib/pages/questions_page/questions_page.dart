import 'package:adir_web_app/pages/questions_page/done_page.dart';
import 'package:adir_web_app/pages/questions_page/widgets/question_content_widget.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'questions_page_design_logic.dart';
part 'questions_page_logic.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int currentIndex = 0;
  bool isLoading = true;
  List<String>? keys;
  TextEditingController currentController = TextEditingController();
  Map<String, dynamic>? allQuestions;
  String? chosenYearOfMake = '2024';
  int indexOfCardBrand = 0;
  int indexOfVehicleAgency = 0;
  int indexReplacementCar = 0;
  bool isVanOrMotorcycle = false;
  bool isPrivateCarOrConvertible = false;
  bool enableSelection = true;
  int yearOfMakeGap = 0;
  String natureOfVehicleAnswer = '';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Description of the Risk'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentQuestion['languages']['EN'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  //TODO This must be using conditions
                  questionContentWidget(context, currentQuestion, setState,
                      controller: currentController,
                      chosenYear: chosenYearOfMake,
                      enabled: enableSelection,
                      callCalendarBack: yearOfMakeCallBack),
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
                                backgroundColor: Theme.of(context).primaryColor,
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
    );
  }
}
