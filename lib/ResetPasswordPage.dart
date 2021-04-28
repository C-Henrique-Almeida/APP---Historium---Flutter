import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wattcopy/common/WattcopyScaffold.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _firebaseAuth = FirebaseAuth.instance;

  final _emailController = TextEditingController();

  void resetPassword() {
    if(_formKey.currentState.validate()) {
      _firebaseAuth.sendPasswordResetEmail(email: _emailController.text)
      .then((value) {
        setState(() {
          _emailController.text = '';
            showDialog(
              context: context,
              builder: (BuildContext buildContext) {
                return AlertDialog(
                  title: Text('E-mail enviado'),
                  content: Text(
                    'Cheque sua caixa de mensagens para prosseguir com' + 
                    'a redefinição da senha'
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Ok')
                    )
                  ],
                );
              }
            );
        });
      })
      .catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(error.message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ok')
                )
              ],
            );
          }
        );
      }); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return WattcopyScaffold(
      backButton: true,
      caption: 'Redefinir senha',
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Seu email cadastrado...' ,
                  labelText: 'Email',
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.8,
                ),
                validator: (value) {
                  if(value.isEmpty) return 'Esse campo não deve ficar vazio!';

                  return null;
                },
              ),
              SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Enviar e-mail'),
                  onPressed: resetPassword,
                ),
              ) 
            ],
          ),
        ) 
      )
    );
  }
}