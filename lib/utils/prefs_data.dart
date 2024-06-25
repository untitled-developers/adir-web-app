import 'package:adir_web_app/common/questions.dart';
import 'package:adir_web_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LocalizationPreference {
  String locale;

  LocalizationPreference(this.locale);
}

class UserHolder {
  User? user;

  UserHolder(this.user);
}

class DataHolder {
  DataHolder();
}

//TODO Check if this's needed
class ApplicationPreferences {
  bool isDarkMode;

  ApplicationPreferences({this.isDarkMode = false});
}

class PrefsData extends ChangeNotifier {
  late final UserHolder _userHolder;

  //TODO Check if this's needed
  late final DataHolder _dataHolder;
  Map<String, dynamic> _questions = staticQuestions;

  User? get user => _userHolder.user;

  late final ApplicationPreferences _applicationPreferences;

  ApplicationPreferences get applicationPreferences => _applicationPreferences;

  Map<String, dynamic> get questions => _questions;

  PrefsData(this._userHolder, this._applicationPreferences, this._dataHolder);

  void updateUser(User? user) {
    _userHolder.user = user;
    notifyListeners();
  }

  void updateQuestions(Map<String, dynamic> newQuestions) {
    _questions.forEach((key, value) {
      if (newQuestions[key]['answer'] != null) {
        if (value['answer'].toString().isEmpty ||
            value['answer'] != newQuestions[key]['answer']) {
          updateAnswer(key, newQuestions[key]['answer']);
        }
      }
    });

    notifyListeners();
  }

  void updateAnswer(String key, dynamic answer) {
    Map<String, dynamic> updatedQuestions = Map.from(_questions);
    updatedQuestions[key]['answer'] = answer;
    _questions = updatedQuestions;
    notifyListeners();
  }

  void updateApplicationPreferences({required bool isDarkMode}) {
    _applicationPreferences.isDarkMode = isDarkMode
        ? _applicationPreferences.isDarkMode
        : _applicationPreferences.isDarkMode = false;
    notifyListeners();
  }

  int getFormFinishedPercentage() {
    int totalQuestionsLength = _questions.length;
    int answeredQuestionsLength = 0;

    _questions.forEach((key, value) {
      if (value['answer'] != null && value['answer'].toString().isNotEmpty) {
        answeredQuestionsLength++;
      }
    });

    if (answeredQuestionsLength == totalQuestionsLength - 1 &&
        ((_questions['registrationnumber']['answer'] != null &&
                _questions['registrationnumber']['answer']
                    .toString()
                    .isEmpty) ||
            (_questions['chassisnumber']['answer'] != null &&
                _questions['chassisnumber']['answer'].toString().isEmpty))) {
      print('testt');
      return 100;
    }

    return (answeredQuestionsLength.toDouble() / totalQuestionsLength * 100)
        .toInt();
  }
}
