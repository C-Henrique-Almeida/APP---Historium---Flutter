import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wattcopy/common/WattcopyScaffold.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fb = FirebaseDatabase.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() {
    if(!_formKey.currentState.validate()) {
      return;
    }

    _firebaseAuth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text
    )
    .then((value) => print('logado!'))
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: WattcopyScaffold(
        caption: "Login",
        backButton: true,
        body: SingleChildScrollView(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildField(
                    "Email",
                    _emailController,
                    hintText: 'Seu email...'
                  ),
                  buildField(
                    "Senha",
                    _passwordController,
                    hintText: 'Sua senha...',
                    obscureText: true
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      child: Text("Login")
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    child: TextButton(
                      child: Text('Esqueceu sua senha?'),
                      onPressed: (){
                        Navigator.pushNamed(context, '/password-reset');
                      },
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      )
    );
  }

  Widget buildField(
		String label, 
		TextEditingController controller,
		{bool obscureText = false, String hintText=''}
	) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: TextFormField(
        validator: (value) {
          if(value.isEmpty) return 'Esse campo não pode estar vazio!';
          return null;
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
        ),
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
