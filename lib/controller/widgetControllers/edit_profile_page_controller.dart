import 'package:firebase_auth/firebase_auth.dart';
import 'package:historium/controller/outputModels/UserOutput.dart';
import 'package:historium/model/services/UserService.dart';

class EditProfilePageController {
  final _auth = FirebaseAuth.instance;
  final _userService = UserService();

  Future<UserOutput> loadUser() async {
    String uid = _auth.currentUser.uid;

    return UserOutput.fromUser(await _userService.loadUser(uid));
  }
}