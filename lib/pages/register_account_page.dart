import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/controller/inputModels/AccountInput.dart';
import 'package:historium/pages/components/fields/EmailField.dart';
import 'package:historium/pages/components/fields/PasswordField.dart';
import 'package:historium/pages/register_user_page.dart';

class RegisterAccountPage extends StatefulWidget {
  
  @override
  _RegisterAccountPageState createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  AccountInput _account;

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
          => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 10
              ),
              alignment: Alignment.center,
              height: MediaQuery.of(buildContext).size.height -
                      Scaffold.of(buildContext).appBarMaxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EmailField(
                        controller: _emailController,
                      ),
                      SizedBox(height: 40),
                      PasswordField(
                        controller: _passwordController,
                      ),
                      SizedBox(height: 40),
                      buildConfirmPasswordField(),
                    ]
                  ),
                  buildContinueButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildConfirmPasswordField() {
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

  Widget buildContinueButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.55,
      child: ElevatedButton(
        onPressed: () => _continuePressedHandler(context),
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
          'Continuar',
          style: GoogleFonts.roboto(
            fontSize: 24
          ),
        )
      ),
    ); 
  }

  void _continuePressedHandler(BuildContext context) {
    if(!_formKey.currentState.validate()) return;

    if(_account == null) _account = AccountInput.empty();

    _account.email = _emailController.text;
    _account.password = _passwordController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterUserPage(_account)
      )
    );
  }
}