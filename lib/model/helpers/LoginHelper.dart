import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:historium/assemblers/ErrorAssembler.dart';


class LoginHelper {

  final _firebaseAuth = fbAuth.FirebaseAuth.instance;


  Future<void> loginWithEmailAndPassword(
    String email,
    String password
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    }
    on fbAuth.FirebaseAuthException catch(exception) {
      return Future.error(await ErrorAssembler().toError(exception));
    }
  }

}