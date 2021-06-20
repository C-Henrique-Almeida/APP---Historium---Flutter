import 'package:historium/model/entity/Entity.dart';

class User extends Entity {

  User(String uid) : super(uid);

  String username;
  String profilePictureUrl;
  DateTime birthDate;

  List<String> favouriteGenres;
}