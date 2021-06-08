class UserInput {

  String uid;
  String username;
  String profilePictureUri;
  DateTime birthDate;
  List<String> favouriteGenres;

  UserInput();

  factory UserInput.empty() {
    UserInput userInput = UserInput();

    userInput.favouriteGenres = [];

    return userInput; 
  }
}