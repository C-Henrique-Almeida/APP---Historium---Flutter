import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/pages/common/components/EmailField.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  passwordReset() async {
    if(!_formKey.currentState.validate()){
      return Future.error('Um ou mais campos não foram preenchidos corretamente');
    }

    try {
      await firebaseAuth.sendPasswordResetEmail(email: _emailController.text);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
        'Email para recuperação enviado!'
      )));
    } on FirebaseAuthException catch (error) {
      String title;
      String message;

      switch(error.code) {
        case 'invalid-email':
          title = 'Email inválido';
          message = 'Esse endereço de e-mail não parece ser válido';
          break;
        case 'user-not-found':
          title = 'Usuário não encontrado';
          message = 'Nenhum usuário com esse e-mail foi encontrado';
          break;
        default:
          title = 'Erro inesperado';
          message = 'Um erro inesperado aconteceu, por favor tente mais tarde.';
          print(error.code);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Recuperar senha',
          style: GoogleFonts.rokkitt(
            fontSize: 24,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (BuildContext buildContext, BoxConstraints constraints)
          => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    EmailField(
                      controller: _emailController,
                    ),
                    SizedBox(height: 24,),
                    FractionallySizedBox(
                      widthFactor: 0.55,
                      child: ElevatedButton(
                        onPressed: passwordReset,
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
                          'Recuperar',
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