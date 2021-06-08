import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:historium/assemblers/ErrorAssembler.dart';
import 'package:historium/model/entity/User.dart';


class LoginHelper {

  final _firebaseAuth = fbAuth.FirebaseAuth.instance;


  Future<User> loginWithEmailAndPassword(
    String email,
    String password
  ) async {
    User user;

    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      user.uid = userCredential.user.uid;

    }
    on fbAuth.FirebaseAuthException catch(exception) {
      return Future.error(await ErrorAssembler().toError(exception));
    }

    return user;
  }

}