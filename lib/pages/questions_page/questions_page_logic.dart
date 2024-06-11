part of 'questions_page.dart';

extension QuestionsPageLogic on _QuestionsPageState {
  initializeData() async {
    allQuestions = {};
    allQuestions
        ?.addAll(Provider.of<PrefsData>(context, listen: false).questions);
    keys = allQuestions?.keys.toList();
    indexOfCardBrand = keys!.indexOf('carbrand');
    indexOfVehicleAgency = keys!.indexOf('vehicleagencyrepair');
    indexReplacementCar = keys!.indexOf('replacementcar');

    setState(() => isLoading = false);
  }

  yearOfMakeCallBack(String date) => setState(() => chosenYearOfMake = date);

  checkNatureOfVehicleAnswer() {
    if (Provider.of<PrefsData>(context, listen: false)
        .questions['natureofvehicle']['answer']
        .isNotEmpty) {
      var answer = Provider.of<PrefsData>(context, listen: false)
              .questions['natureofvehicle']['answer'] ??
          '';
      if (answer != 'Private Car') {
        keys!.removeWhere((element) => element == 'carbrand');
        Provider.of<PrefsData>(context, listen: false)
            .updateAnswer('carbrand', '');
      } else {
        if (!keys!.contains('carbrand'))
          keys!.insert(indexOfCardBrand, 'carbrand');
      }
    }
  }

  checkInsuranceTypeAnswer() {
    if (Provider.of<PrefsData>(context, listen: false)
        .questions['insuranceType']['answer']
        .isNotEmpty) {
      var answer = Provider.of<PrefsData>(context, listen: false)
              .questions['insuranceType']['answer'] ??
          '';
      if (answer == 'All Risks + (MPF)') {
        keys!.removeWhere((element) => element == 'replacementcar');
        Provider.of<PrefsData>(context, listen: false)
            .updateAnswer('replacementcar', '');
        if (!keys!.contains('vehicleagencyrepair')) {
          keys!.insert(indexOfVehicleAgency, 'vehicleagencyrepair');
        }
      } else {
        keys!.removeWhere((element) => element == 'vehicleagencyrepair');
        Provider.of<PrefsData>(context, listen: false)
            .updateAnswer('vehicleagencyrepair', '');
        if (!keys!.contains('replacementcar')) {
          keys!.insert(indexOfVehicleAgency, 'replacementcar');
        }
      }
    }
  }
}
