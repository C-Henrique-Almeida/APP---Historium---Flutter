import 'package:historium/model/entity/User.dart';
import 'package:historium/model/helpers/UserHelper.dart';

class UserService {
  final _userHelper = UserHelper();

  Future<void> saveUser(User user) async {
    await _userHelper.save(user);
  }

  Future<User> loadUser(String id) async {
    return await _userHelper.load(id);
  }

  Future<void> deleteUser(String id) async {
    await _userHelper.delete(id);
  }
} 