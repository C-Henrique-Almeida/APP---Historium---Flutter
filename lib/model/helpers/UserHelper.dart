import 'package:historium/model/entity/User.dart';
import 'package:historium/model/helpers/helper.dart';

class UserHelper extends Helper<User> {
  @override
  Map<String, dynamic> entityToMap(User entity) {
    return {
      'uid': entity.id,
      'profilePictureUrl': entity.profilePictureUrl,
      'username': entity.username,
      'birthDate': entity.birthDate.millisecondsSinceEpoch,
      'favouriteGenres': entity.favouriteGenres,
    };
  }

  @override
  User entityFromMap(Map<String, dynamic> map) {
    final user = User(map['uid']);

    user.profilePictureUrl = map['profilePictureUrl'];
    user.username = map['username'];
    user.birthDate = DateTime.fromMillisecondsSinceEpoch(map['birthDate']);

    user.favouriteGenres = List<String>.from(map['favouriteGenres']);

    return user;
  }
}