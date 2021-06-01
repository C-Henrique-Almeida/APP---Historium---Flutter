class AccountRegisterInfo {

  String email;
  String password;
  String profilePicturePath;
  DateTime birthDate;
  String username;
  List<String> favouriteBookGenres;

  @override
  String toString() {
    return '''
    email: $email,
    password: $password,
    profilePicturePath:$profilePicturePath,
    birthDate: ${birthDate?.toIso8601String()},
    username: $username
    ''';
  }
}