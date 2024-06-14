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
}
