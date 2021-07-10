import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/model/helpers/BookGenreHelper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:historium/controller/widgetControllers/edit_profile_page_controller.dart';

class EditProfilePage extends StatefulWidget {

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {


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
		print('Hello World');

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
            case ConnectionState.waiting:
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
				Container(
					height: MediaQuery.of(_context).size.height -
									Scaffold.of(_context).appBarMaxHeight,
					padding: EdgeInsets.symmetric(
						vertical: 50,
						horizontal: 10
					),
					child: SingleChildScrollView(
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
				)
        ,
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
    
		favouriteGenreFieldController.text = favouriteGenres.join(', ');
  }
}
