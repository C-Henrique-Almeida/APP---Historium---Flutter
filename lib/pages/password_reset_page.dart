import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/assemblers/ErrorAssembler.dart';
import 'package:historium/errors/Error.dart';
import 'package:historium/pages/components/fields/EmailField.dart';
import 'package:historium/pages/components/dialogs/ErrorDialog.dart';

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
    } on FirebaseAuthException catch (exception) {
      Error error = await ErrorAssembler().toError(exception);

      ErrorDialog.show(context, error);
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