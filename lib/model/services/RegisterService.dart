import 'package:firebase_auth/firebase_auth.dart';
import 'package:historium/assemblers/ErrorAssembler.dart';
import 'package:historium/controller/inputModels/AccountInput.dart';
import 'package:historium/model/helpers/UserHelper.dart';

class RegisterService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _userHelper = UserHelper();
  
  Future<void> registerAccount(AccountInput account) async {
    try {
      account.userInput.uid =  (await _firebaseAuth.createUserWithEmailAndPassword(
        email: account.email,
        password: account.password
      )).user.uid;

      _userHelper.save(account.userInput);
    }
    on FirebaseAuthException catch (error) {
      return Future.error(await ErrorAssembler().toError(error));
    }
  }
}