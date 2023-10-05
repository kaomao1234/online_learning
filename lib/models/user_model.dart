class UserModel {
  late int userid;
  late String username, email, password, fullname, birthdate;

  UserModel();
  factory UserModel.fromJson(
      {required String username,
      required String email,
      required String password,
      required String fullname,
      required String birthdate}) {
    UserModel model = UserModel()
      ..username = username
      ..email = email
      ..password = password
      ..fullname = fullname
      ..birthdate = birthdate;
    return model;
  }
  Map<String, dynamic> get toJson => {
        "username": username,
        "email": email,
        "password": password,
        "fullname": fullname,
        "birthdate": birthdate
      };
}
