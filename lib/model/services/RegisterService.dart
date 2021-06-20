
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_storage/firebase_storage.dart' as fbs;
import 'package:historium/assemblers/ErrorAssembler.dart';
import 'package:historium/controller/inputModels/AccountInput.dart';
import 'package:historium/controller/inputModels/UserInput.dart';
import 'package:historium/model/entity/User.dart';
import 'package:historium/model/helpers/UserHelper.dart';

class RegisterService {
  final _firebaseAuth = fba.FirebaseAuth.instance;
  final _storage = fbs.FirebaseStorage.instance;
  final _userHelper = UserHelper();
  
  Future<void> registerAccount(AccountInput account) async {
    try {
      account.userInput.uid =  (await _firebaseAuth.createUserWithEmailAndPassword(
        email: account.email,
        password: account.password
      )).user.uid;

      await registerUser(account.userInput);
    }
    on fba.FirebaseAuthException catch (error) {
      return Future.error(await ErrorAssembler().toError(error));
    }
  }

  Future<void> registerUser(UserInput userInput) async {
    final user = User(userInput.uid);

    final pictureReference = _storage.ref('profilePictures')
    .child(userInput.uid);

    await pictureReference
    .putFile(File(userInput.profilePictureUri))
    .whenComplete(() => null);

    user.profilePictureUrl = await pictureReference.getDownloadURL();
    user.username = userInput.username;
    user.birthDate = userInput.birthDate;
    user.favouriteGenres = userInput.favouriteGenres;

    await _userHelper.save(user);
  }
}