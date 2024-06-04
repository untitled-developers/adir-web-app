class User {
  String? id;
  String? name;
  String? mobile;
  String? language;
  DateTime? dateFormat;

  User.fromMap(Map<String, dynamic> model) {
    id = model['userid'];
    name = model['name'];
    mobile = model['mobile'];
    language = model['language'];
  }
}
