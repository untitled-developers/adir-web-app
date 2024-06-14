// part of 'questions_page.dart';
//
// extension QuestionsPageLogic on _QuestionsPageState {
//   initializeData() async {
//     allQuestions = {};
//     allQuestions
//         ?.addAll(Provider.of<PrefsData>(context, listen: false).questions);
//     keys = allQuestions?.keys.toList();
//     indexOfCardBrand = keys!.indexOf('carbrand');
//     indexOfVehicleAgency = keys!.indexOf('vehicleagencyrepair');
//     indexReplacementCar = keys!.indexOf('replacementcar');
//     String natureOfVehicleAnswer =
//         Provider.of<PrefsData>(context, listen: false)
//             .questions['natureofvehicle']['answer'];
//     isVanOrMotorcycle =
//         natureOfVehicleAnswer == 'Motorcycle' || natureOfVehicleAnswer == 'Van';
//
//     setState(() => isLoading = false);
//   }
//
//   yearOfMakeCallBack(String date) => setState(() => chosenYearOfMake = date);
//
//   checkNatureOfVehicleAnswer() {
//     if (Provider.of<PrefsData>(context, listen: false)
//         .questions['natureofvehicle']['answer']
//         .isNotEmpty) {
//       var answer = Provider.of<PrefsData>(context, listen: false)
//               .questions['natureofvehicle']['answer'] ??
//           '';
//       updateEnable(answer);
//       if (answer != 'Private Car') {
//         keys!.removeWhere((element) => element == 'carbrand');
//         Provider.of<PrefsData>(context, listen: false)
//             .updateAnswer('carbrand', '');
//       } else {
//         if (!keys!.contains('carbrand'))
//           keys!.insert(indexOfCardBrand, 'carbrand');
//       }
//     }
//   }
//
//   checkYearOfMakeGap() {
//     if (Provider.of<PrefsData>(context, listen: false)
//         .questions['yearofmake']['answer']
//         .isNotEmpty) {
//       var answer = Provider.of<PrefsData>(context, listen: false)
//               .questions['yearofmake']['answer'] ??
//           '';
//       yearOfMakeGap = DateTime.now().year - int.parse(answer);
//     }
//   }
//
//   checkInsuranceTypeAnswer() {
//     if (Provider.of<PrefsData>(context, listen: false)
//         .questions['insurancetype']['answer']
//         .isNotEmpty) {
//       var answer = Provider.of<PrefsData>(context, listen: false)
//               .questions['insurancetype']['answer'] ??
//           '';
//       if (isVanOrMotorcycle && answer == 'All Risks (MRF)') {
//         _caseVanMotoAllRisks();
//       } else if (isPrivateCarOrConvertible && answer == 'All Risks (MRF)') {
//         _caseCarConvertibleAllRisks();
//       } else if (answer == 'All Risks + (MPF)') {
//         if (yearOfMakeGap < 4) {
//           _caseOne;
//         } else if (yearOfMakeGap == 4 || yearOfMakeGap == 5) {
//           _caseTwo();
//         } else {
//           _caseThree();
//         }
//       }
//     }
//   }
//
//   _caseVanMotoAllRisks() {
//     keys!.removeWhere((element) => element == 'vehicleagencyrepair');
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('vehicleagencyrepair', '');
//     if (!keys!.contains('replacementcar')) {
//       keys!.insert(indexOfVehicleAgency, 'replacementcar');
//     }
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('replacementcar', 'No');
//     setState(() => enableSelection = false);
//   }
//
//   _caseCarConvertibleAllRisks() {
//     keys!.removeWhere((element) => element == 'vehicleagencyrepair');
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('vehicleagencyrepair', '');
//     if (!keys!.contains('replacementcar')) {
//       keys!.insert(indexOfVehicleAgency, 'replacementcar');
//     }
//   }
//
//   _caseOne() {
//     keys!.removeWhere((element) => element == 'replacementcar');
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('replacementcar', '');
//     if (!keys!.contains('vehicleagencyrepair')) {
//       keys!.insert(indexOfVehicleAgency, 'vehicleagencyrepair');
//     }
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('vehicleagencyrepair', 'Yes');
//     setState(() => enableSelection = false);
//   }
//
//   _caseTwo() {
//     keys!.removeWhere((element) => element == 'replacementcar');
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('replacementcar', '');
//     if (!keys!.contains('vehicleagencyrepair')) {
//       keys!.insert(indexOfVehicleAgency, 'vehicleagencyrepair');
//     }
//   }
//
//   _caseThree() {
//     keys!.removeWhere((element) => element == 'replacementcar');
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('replacementcar', '');
//     if (!keys!.contains('vehicleagencyrepair')) {
//       keys!.insert(indexOfVehicleAgency, 'vehicleagencyrepair');
//     }
//     Provider.of<PrefsData>(context, listen: false)
//         .updateAnswer('vehicleagencyrepair', 'No');
//     setState(() => enableSelection = false);
//   }
//
//   updateEnable(dynamic answer) {
//     if (answer == 'Motorcycle' || answer == 'Van') {
//       isVanOrMotorcycle = true;
//       isPrivateCarOrConvertible = false;
//     } else if (answer == 'Private Car' || answer == 'Convertible Soft Top') {
//       isVanOrMotorcycle = false;
//       isPrivateCarOrConvertible = true;
//     } else {
//       isVanOrMotorcycle = false;
//       isPrivateCarOrConvertible = false;
//     }
//     setState(() {});
//   }
// }
