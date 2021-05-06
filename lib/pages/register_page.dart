import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/pages/common/components/EmailField.dart';
import 'package:historium/pages/common/components/PasswordField.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController(); // Will be useful...
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  void _clearFields() {
    setState(() {
      _emailController.text = '';
      _usernameController.text = '';
      _passwordController.text = '';
      _confirmPasswordController.text = '';
    });
  }
  
  void register(BuildContext context) async {
    if(!_formKey.currentState.validate()) return Future.error(
      'Um ou mais campos não foram preenchidos corretamente'
    );

    try{
      await firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      /*
        After modelling the data, user.toMap() will be inserted
        in the real time database.
      */

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
        'Usuário cadastrado!'
      )));

      _clearFields();
    } on FirebaseAuthException catch (error) {
      String title;
      String message;

      print(error.code);

      switch(error.code) {
        case 'invalid-email':
          title = 'Email inválido';
          message = 'Esse endereço de email não é valido';
          break;
        default:
          title = 'Erro inesperado';
          message = 'Um erro inesperado aconteceu, por favor tente mais tarde.';
          break;
      }

      showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(_context).pop(), child: Text('Ok')),
            ],
          );
        }
      );
    }
  }


  Widget usernameField() {
    return TextFormField(
      controller: _usernameController,
      validator: (value) {
        if(value.isEmpty) return 'Esse campo não pode estar vazio.';
        return null;
      },
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: 'Nome de usuário',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      validator: (value) {
        if(value.isEmpty) return 'Esse campo não pode estar vazio.';
        if(_passwordController.text != value) return 'As senhas não batem';
        return null;
      },
      controller: _confirmPasswordController,
      obscureText: true,
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: 'Confirmar senha',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Cadastro',
          style: GoogleFonts.rokkitt(
            fontSize: 24,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (BuildContext buildContext, BoxConstraints constraints)
          => Container(
            alignment: Alignment.center,
            constraints: constraints,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: 480,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EmailField(
                      controller: _emailController,
                    ),
                    usernameField(),
                    PasswordField(
                      controller: _passwordController,
                    ),
                    confirmPasswordField(),
                    FractionallySizedBox(
                      widthFactor: 0.55,
                      child: ElevatedButton(
                        onPressed: () => register(context),
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
                    ) 
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}