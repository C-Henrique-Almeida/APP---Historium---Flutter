import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_storage/firebase_storage.dart' as fbs;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/model/entity/User.dart';
import 'package:historium/model/helpers/BookGenreHelper.dart';
import 'package:historium/model/services/UserService.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {


  final formKey = GlobalKey<FormState>(); 
  final _genreList = BookGenreHelper().listAll();

  // controllers
  final usernameController = TextEditingController();
  final birthDateFieldController = TextEditingController();
  final favouriteGenreFieldController = TextEditingController();
  EditProfilePageController controller;
  
  // state date
  String initialProfilePictureUrl = '';
  String profilePictureUri = '';
  DateTime birthDate = DateTime.now();
  List<String> favouriteGenres = [];

  @override
  void initState() {
    super.initState();

    controller = EditProfilePageController(this);
  }

  void update() => setState(() => null);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: controller.requestPop,
        ),
        title: Text(
          "Perfil",
          style: GoogleFonts.rokkitt(
            fontSize: 24,
          )
        ),
        backgroundColor: Colors.black,
        actions: <Widget> [
          IconButton(
            onPressed: controller.save,
            icon: Icon(Icons.check)
          )
        ],
      ),
      body: FutureBuilder(
        future: controller.loadUserData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          Widget body;
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              body =  Expanded(child: Text('Carregando .'),);
              break;
            case ConnectionState.waiting:
              body = Expanded(child: Text('Carregando ..'),);
              break;
            case ConnectionState.active:
              body = Expanded(child: Text('Carregando...'),);
              break;
            case ConnectionState.done:
              body = displayPage();
              break;
          }
      
           return body;
        }
      )
    );
  }

  Widget displayPage() {
    return Form(
      key: formKey,
      child: LayoutBuilder(
        builder: (BuildContext _context, BoxConstraints constraints) =>
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(_context).size.height -
                    Scaffold.of(_context).appBarMaxHeight,
            padding: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 10
            ),
            child: Column(
              children: [
                _buildProfilePictureContainer(context),
                SizedBox(height: 60),
                _buildUsernameField(context),
                SizedBox(height: 30),
                _buildBirthDateField(context),
                SizedBox(height: 30),
                _buildFavouriteGenresField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureContainer(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedImagePath = (await ImagePicker()
          .getImage(source: ImageSource.gallery))?.path
          ?? '';

        if(selectedImagePath.isNotEmpty) {
          setState(() {
            profilePictureUri = selectedImagePath;
          });
        }
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 150,
          maxWidth: 150
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: 
              profilePictureUri != null &&
              profilePictureUri.isNotEmpty ?
              FileImage(File(profilePictureUri)) :
              NetworkImage(initialProfilePictureUrl)
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        hintText: "Seu nome",
      ),
      validator: (String value) {
        if(value.isEmpty) {
          return 'Esse campo deve ser preenchido';
        } 
        return null;
      },
    );
  }

  Widget _buildBirthDateField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: controller.pickDate,
      decoration: InputDecoration(
        hintText: "Sua data de nascimento",
      ),
      controller: birthDateFieldController,
      validator: (String value) {
        if(value.isEmpty) {
          return 'Esse campo deve ser preenchido';
        } 
        return null;
      },
    );
  }

  Widget _buildFavouriteGenresField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: ()  => _showPickGenresScreen(context),
      decoration: InputDecoration(
        hintText: "Seu estilo",
      ),
      controller: favouriteGenreFieldController,
      validator: (String value) {
        if(value.isEmpty) {
          return 'Esse campo deve ser preenchido';
        } 
        return null;
      }
    );
  }

  void _showPickGenresScreen(BuildContext context) async {
    _genreList.sort((String a, String b) => a.compareTo(b));

    await showDialog(
      context: context,
      builder: (BuildContext context) => 
      Dialog(
        child: Scaffold(
          persistentFooterButtons: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text("Ok"),
                )
              ],  
            )
          ],
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Selecione seus generos favoritos"),
          ),
          body: ListView.separated(
            itemCount: _genreList.length,

            separatorBuilder: (BuildContext _context, int index) =>
            SizedBox(height: 20,),

            itemBuilder: (BuildContext _context, int index) => 
            StatefulBuilder(
              builder: (BuildContext context, setDialogState) =>
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(
                      10
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      favouriteGenres.contains(_genreList[index]) ?
                        Colors.black : Colors.white,
                    ),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      color: favouriteGenres
                        .contains(_genreList[index]) ?
                        Colors.black : Colors.white,
                    )),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    )
                  ),
                  onPressed: () {
                    setDialogState(() {
                      if(favouriteGenres.contains(_genreList[index])) {
                        favouriteGenres.remove(_genreList[index]);
                      }
                      else {
                        favouriteGenres.add(_genreList[index]);
                      }
                    });
                  },
                  child: Text(
                    _genreList[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: favouriteGenres
                        .contains(_genreList[index]) ?
                        Colors.white : Colors.black,
                    ),
                  ),
                ),
              )
            ),
          ),
        ),
      )
    );

    setState(() {
      favouriteGenreFieldController.text =
        favouriteGenres.join(', ');
    });
  }
}

class EditProfilePageController {
  final _auth = fba.FirebaseAuth.instance;
  final _storage = fbs.FirebaseStorage.instance;
  final _userService = UserService();

  BuildContext context;

  _EditProfilePageState state;

  bool userLoaded = false;

  EditProfilePageController(this.state);

  Future<void> loadUserData() async {
    if(userLoaded) return Future.value();

    String uid = _auth.currentUser.uid;

    final user = await _userService.loadUser(uid);

    state.birthDateFieldController.text = _toFormatedDate(user.birthDate);
    state.favouriteGenreFieldController.text = user.favouriteGenres.join(', ');

    state.initialProfilePictureUrl = user.profilePictureUrl;
    state.profilePictureUri = '';
    state.usernameController.text = user.username ?? '';
    state.birthDate = user.birthDate;
    state.favouriteGenres = user.favouriteGenres;

    userLoaded = true;
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
      state.update();
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
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Salvando alterações...'))
    );

    User user = User(_auth.currentUser.uid);

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

    user.username = state.usernameController.text;
    user.birthDate = state.birthDate;
    user.favouriteGenres = state.favouriteGenres;

    await _userService.saveUser(user);

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    
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