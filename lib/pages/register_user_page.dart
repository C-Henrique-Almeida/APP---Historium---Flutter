import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/errors/Error.dart';
import 'package:historium/model/helpers/BookGenreHelper.dart';
import 'package:historium/controller/inputModels/AccountInput.dart';
import 'package:historium/controller/inputModels/UserInput.dart';
import 'package:historium/pages/components/dialogs/ErrorDialog.dart';
import 'package:historium/model/services/RegisterService.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUserPage extends StatefulWidget {

  final AccountInput account;

  RegisterUserPage(this.account);

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {

  final  _formKey = GlobalKey<FormState>(); 

  final _usernameController = TextEditingController();
  final _birthDateFieldController = TextEditingController();
  final _genresFieldController = TextEditingController();

  final _genreList = BookGenreHelper().listAll();

  UserInput _user;

  @override
  void initState() {
    super.initState();

    _user = widget.account.userInput;

    _usernameController.text = _user.username ?? '';
    _birthDateFieldController.text = _toFormatedDate(_user.birthDate);
    _genresFieldController.text = _user.favouriteGenres?.join(', ') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: GoogleFonts.rokkitt(
            fontSize: 24,
          )
        ),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String selectedImagePath = (await ImagePicker()
                            .getImage(source: ImageSource.gallery))
                            .path;

                          if(selectedImagePath.isNotEmpty) {
                            setState(() {
                              _user.profilePictureUri =
                                selectedImagePath;
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
                              image: (
                                _user.profilePictureUri != null &&
                                _user.profilePictureUri.isNotEmpty ?
                                FileImage(
                                  File(
                                    _user.profilePictureUri
                                  )
                                ) :
                                AssetImage('assets/person-circle-1.png'))
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      TextFormField(
                        controller: _usernameController,
                        onChanged: (String value) =>
                          _user.username = value,
                        decoration: InputDecoration(
                          hintText: "Seu nome",
                        ),
                        validator: (String value) {
                          if(value.isEmpty) {
                            return 'Esse campo deve ser preenchido';
                          } 
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        readOnly: true,
                        onTap: _pickDate,
                        decoration: InputDecoration(
                          hintText: "Sua data de nascimento",
                        ),
                        controller: _birthDateFieldController,
                        validator: (String value) {
                          if(value.isEmpty) {
                            return 'Esse campo deve ser preenchido';
                          } 
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        readOnly: true,
                        onTap: ()  => _pickGenres(context),
                        decoration: InputDecoration(
                          hintText: "Seu estilo",
                        ),
                        controller: _genresFieldController,
                        validator: (String value) {
                          if(value.isEmpty) {
                            return 'Esse campo deve ser preenchido';
                          } 
                          return null;
                        }
                      ),
                    ],
                  ),
                  _buildRegisterButton(context),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  void _pickDate() async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: _user.birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
    );

    if(dateTime != null){
      setState(() {
        _user.birthDate = dateTime;

        _birthDateFieldController.text = _toFormatedDate(dateTime);
      });
    }
  }


  void _pickGenres(BuildContext context) async {
    _genreList.sort((String a, String b) => a.compareTo(b));

    await showDialog(
      context: context,
      builder: (BuildContext context) => 
      Dialog(
        child: Scaffold(
          persistentFooterButtons: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text("Ok")
            ),
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
                      _user.favouriteGenres.contains(_genreList[index]) ?
                        Colors.black : Colors.white,
                    ),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      color: _user.favouriteGenres
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
                      if(_user.favouriteGenres.contains(_genreList[index])) {
                        _user.favouriteGenres
                          .remove(_genreList[index]);
                      }
                      else {
                        _user.favouriteGenres
                          .add(_genreList[index]);
                      }
                    });
                  },
                  child: Text(
                    _genreList[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: _user.favouriteGenres
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
      _genresFieldController.text =
        _user.favouriteGenres.join(', ');
    });
  }

  Widget _buildRegisterButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.55,
      child: ElevatedButton(
        onPressed: () => _register(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          )),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 20)
          ), 
        ),
        child: Text(
          'Registrar',
          style: GoogleFonts.roboto(
            fontSize: 24
          ),
        )
      ),
    ); 
  }

  Future<void> _register(BuildContext context) async {
    if(!_formKey.currentState.validate()) return;

    try {
      await RegisterService().registerAccount(widget.account);

      Navigator.pop(context);
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: Text('Registrado com sucesso'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Text('Registro efetuado com sucesso!'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(_context).pop(), child: Text('Ok')
              ),
            ],
          );
        }
      );
    }
    on Error catch(error) {
      if(error is Error) {
        ErrorDialog.show(context, error);
      }
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
}