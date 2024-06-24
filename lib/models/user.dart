import 'package:intl/intl.dart';

class User {
  int? id;
  String? title;
  double? formFinishedPercentage;
  String? firstName;
  String? fatherName;
  String? maidenName;
  String? familyName;
  String? nationality;
  String? email;
  String? occupation;
  DateTime? dateOfBirth;
  String? placeOfBirth;
  String? applicantPhone;

  User.fromMap(Map<String, dynamic> model) {
    id = model['id'];
    title = model['title'] ?? '';
    formFinishedPercentage = model['form_finished_percentage'] != null
        ? double.parse(model['form_finished_percentage'])
        : 0;
    firstName = model['first_name'] ?? '';
    fatherName = model['father_name'] ?? '';
    maidenName = model['maiden_name'] ?? '';
    familyName = model['family_name'] ?? '';
    nationality = model['nationality'] ?? '';
    email = model['email'] ?? '';
    occupation = model['occupation'] ?? '';
    dateOfBirth = model['date_of_birth'] != null
        ? DateTime.parse(DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(model['date_of_birth'])))
        : null;
    placeOfBirth = model['place_of_birth'] ?? '';
    applicantPhone = model['applicant_phone'] ?? '';
  }
}
