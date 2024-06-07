import 'package:intl/intl.dart';

class User {
  int? id;
  String? title;
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
    firstName = model['title'] ?? '';
    firstName = model['first_name'] ?? '';
    fatherName = model['father_name'] ?? '';
    maidenName = model['maiden_name'] ?? '';
    familyName = model['family_name'] ?? '';
    nationality = model['nationality'] ?? '';
    nationality = model['email'] ?? '';
    nationality = model['occupation'] ?? '';
    dateOfBirth = model['date_of_birth'] != null
        ? DateTime.parse(DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(model['date_of_birth'])))
        : null;
    placeOfBirth = model['place_of_birth'] ?? '';
    applicantPhone = model['applicant_phone'] ?? '';
  }
}
