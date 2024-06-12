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
    String natureOfVehicleAnswer =
        Provider.of<PrefsData>(context, listen: false)
            .questions['natureofvehicle']['answer'];
    isVanOrMotorcycle =
        natureOfVehicleAnswer == 'Motorcycle' || natureOfVehicleAnswer == 'Van';

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
      if (answer == 'Motorcycle' || answer == 'Van') {
        setState(() => isVanOrMotorcycle = true);
      } else {
        setState(() => isVanOrMotorcycle = false);
      }
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
        .questions['insurancetype']['answer']
        .isNotEmpty) {
      var answer = Provider.of<PrefsData>(context, listen: false)
              .questions['insurancetype']['answer'] ??
          '';
      if (isVanOrMotorcycle && answer == 'All Risks (MRF)') {
        keys!.removeWhere((element) => element == 'vehicleagencyrepair');
        Provider.of<PrefsData>(context, listen: false)
            .updateAnswer('vehicleagencyrepair', '');
        if (!keys!.contains('replacementcar')) {
          keys!.insert(indexOfVehicleAgency, 'replacementcar');
        }
        Provider.of<PrefsData>(context, listen: false)
            .updateAnswer('replacementcar', 'No');
        setState(() => enableSelection = false);
      }

      // if (answer == 'All Risks + (MPF)') {
      //   keys!.removeWhere((element) => element == 'replacementcar');
      //   Provider.of<PrefsData>(context, listen: false)
      //       .updateAnswer('replacementcar', '');
      //   if (!keys!.contains('vehicleagencyrepair')) {
      //     keys!.insert(indexOfVehicleAgency, 'vehicleagencyrepair');
      //   }
      // } else {
      //   keys!.removeWhere((element) => element == 'vehicleagencyrepair');
      //   Provider.of<PrefsData>(context, listen: false)
      //       .updateAnswer('vehicleagencyrepair', '');
      //   if (!keys!.contains('replacementcar')) {
      //     keys!.insert(indexOfVehicleAgency, 'replacementcar');
      //   }
      // }
    }
  }
}
