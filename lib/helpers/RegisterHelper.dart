import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:historium/assemblers/ErrorAssembler.dart';
import 'package:historium/models/AccountRegisterInfo.dart';


class RegisterHelper {

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;



  Future<UserCredential> registerWithEmailAndPassword(
    final AccountRegisterInfo accountRegisterInfo
  ) async {
		UserCredential userCredentials;
    var reference = _firestore.collection('/users');

    try {
      userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: accountRegisterInfo.email,
    		password: accountRegisterInfo.password
      );

      reference.doc(userCredentials.user.uid).set(
        {
          'username': accountRegisterInfo.username,
          'birthDate': accountRegisterInfo.birthDate,
          'favouriteGenres': accountRegisterInfo.favouriteBookGenres
        },
      );
    }
    on FirebaseAuthException catch (exception) {
			return Future.error(await ErrorAssembler().toError(exception));
    }

		return userCredentials;
  }

}