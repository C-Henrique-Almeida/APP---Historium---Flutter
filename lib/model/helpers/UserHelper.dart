import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:historium/controller/inputModels/UserInput.dart';

class UserHelper {

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  void save(UserInput user) async {
    final newUserUid = await _firestore.collection('users').doc(user.uid).set({
      'username': user.username,
      'birthDate': user.birthDate,
      'favouriteGenres': user.favouriteGenres
    });

    if(user.profilePictureUri != null && user.profilePictureUri.isNotEmpty) {
      _storage.ref('profilePictures/${user.uid}')
        .putFile(File(user.profilePictureUri));
    }
  }
  
}