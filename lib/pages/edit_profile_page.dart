import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/pages/components/fields/GenrePickerField.dart';
import 'package:image_picker/image_picker.dart';

import 'package:historium/controller/widgetControllers/edit_profile_page_controller.dart';

class EditProfilePage extends StatefulWidget {

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {


  final formKey = GlobalKey<FormState>(); 

  // controllers
  final usernameController = TextEditingController();
  final birthDateFieldController = TextEditingController();
  final favouriteGenreFieldController = TextEditingController();
	final genreController = GenrePickerFieldController();
  EditProfilePageController controller;
  
  // state date
  String initialProfilePictureUrl = '';
  String profilePictureUri = '';
  DateTime birthDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    controller = EditProfilePageController(this);
  }

  void update() => setState(() => {});

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
              body = Container(
								child: Text('Carregando'),
								alignment: Alignment.center,
							);
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
               	GenrePickerField(
									controller: genreController,
									hintText: 'Gêneros favoritos',
								)
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
          .getImage(source: ImageSource.gallery)).path
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
}
