import 'package:historium/model/entity/User.dart';

class UserOutput {

  UserOutput();

  factory UserOutput.fromUser(User user) {
    final userOutput = UserOutput();

    userOutput.profilePictureUrl = user.profilePictureUrl;
    userOutput.username = user.username;
    userOutput.birthDate = user.birthDate;
    userOutput.favouriteGenres = user.favouriteGenres;

    return userOutput;
  }

  String profilePictureUrl;
  String username;
  DateTime birthDate;
  List<String> favouriteGenres;
}