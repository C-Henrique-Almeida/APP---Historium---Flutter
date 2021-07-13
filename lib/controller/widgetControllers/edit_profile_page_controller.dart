import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_storage/firebase_storage.dart' as fbs;
import 'package:flutter/material.dart';
import 'package:historium/controller/outputModels/UserOutput.dart';
import 'package:historium/model/entity/User.dart';
import 'package:historium/model/services/UserService.dart';

import 'package:historium/pages/edit_profile_page.dart';


class EditProfilePageController {
  final _auth = fba.FirebaseAuth.instance;
  final _storage = fbs.FirebaseStorage.instance;
  final _userService = UserService();

	bool userDataLoaded = false;

  BuildContext context;

  EditProfilePageState state;

  EditProfilePageController(this.state);

  Future<void> loadUserData() async {
		if(userDataLoaded) return Future.value();

    String uid = _auth.currentUser.uid;

    final user = UserOutput.fromUser(await _userService.loadUser(uid));

    state.birthDateFieldController.text = _toFormatedDate(user.birthDate);
    state.favouriteGenreFieldController.text = user.favouriteGenres.join(', ');

    state.initialProfilePictureUrl = user.profilePictureUrl;
    state.profilePictureUri = '';
    state.usernameController.text = user.username ?? '';
    state.birthDate = user.birthDate;
		state.genreController.genres = user.favouriteGenres;

		userDataLoaded = true;
  }

  void pickDate() async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: state.birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()

    );

    if(dateTime != null){

      state.birthDate = dateTime;

      state.birthDateFieldController.text = _toFormatedDate(dateTime);
    }
  }

  String _toFormatedDate(DateTime dateTime) {
    if(dateTime == null) return '';

    String result = dateTime.day <= 9 ?
      '0${dateTime.day}':
      '${dateTime.day}';

    result += dateTime.month <= 9 ?
      '/0${dateTime.month}':
      '/${dateTime.month}';

    result += '/${dateTime.year}';

    return result;
  }

  Future<void> save() async {
    if(!state.formKey.currentState.validate()) return;

    User user = User();


    if(
        state.profilePictureUri != null
      && state.profilePictureUri.isNotEmpty
    ) {
      final ref = _storage
      .ref('profilePictures')
      .child(_auth.currentUser.uid);

      await ref
      .putFile(File(state.profilePictureUri))
      .whenComplete(() => null);

      user.profilePictureUrl = await ref.getDownloadURL();
    }
    else {
      user.profilePictureUrl = state.initialProfilePictureUrl;
    }

		user.id = _auth.currentUser.uid;
    user.username = state.usernameController.text;
    user.birthDate = state.birthDate;
    user.favouriteGenres = state.genreController.value;

    await _userService.saveUser(user);

    
    Navigator.pop(context);
  }

  void requestPop() async {
    final exitWithoutSave = await showDialog<bool>(
      context: context,
      builder: (context) => 
      AlertDialog(
        title: Text('Sair sem salvar?'),
        content: Text('Deseja descartar as modificações?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Sim')
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Não')
          )
        ],
      ),
    ) ?? false;

    if(exitWithoutSave) Navigator.pop(context);
  }
}