import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/errors/Error.dart';
import 'package:historium/model/helpers/LoginHelper.dart';
import 'package:historium/pages/components/fields/EmailField.dart';
import 'package:historium/pages/components/dialogs/ErrorDialog.dart';
import 'package:historium/pages/components/fields/PasswordField.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _formState = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 0.0,
        title: Text(
          'Historium',
          style: GoogleFonts.revalia(
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Text(
            'Compartilhando\nhistórias',
            textAlign: TextAlign.center,
            style: GoogleFonts.rokkitt(fontSize: 28, color: Colors.white),
          ),
        ),
        toolbarHeight: 160,
        centerTitle: true,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height -
                      Scaffold.of(context).appBarMaxHeight,
                  child: Form(
                    key: _formState,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            EmailField(
                              controller: _emailController,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            PasswordField(
                              controller: _passwordController,
                            ),
                            TextButton(
                              child: Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () => Navigator.pushNamed(
                                  context, '/reset-password'),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            buildLoginButton(context),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ou',
                              style: GoogleFonts.rokkitt(fontSize: 22),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            buildLoginWithGoogleButton(),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Ainda não se cadastrou?',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                              child: Text(
                                'Registre-se aqui',
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/register'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 8,
        )),
        backgroundColor: MaterialStateProperty.all(Colors.black),
        textStyle: MaterialStateProperty.all(GoogleFonts.roboto(
          fontSize: 24,
        )),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)))),
      ),
      onPressed: () => login(context),
      child: Text('Login'),
    );
  }

  Widget buildLoginWithGoogleButton() {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        )),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        textStyle: MaterialStateProperty.all(GoogleFonts.roboto(
          fontSize: 24,
        )),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)))),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icon-google.png'),
          SizedBox(
            width: 10,
          ),
          Text('Logar com o google'),
        ],
      ),
    );
  }

  /*
    This function attempts a signInWithEmailAndPassword operation
    on Firebase
  */
  void login(BuildContext context) {
    LoginHelper()
        .loginWithEmailAndPassword(
            _emailController.text, _passwordController.text)
        .then((value) => Navigator.pushReplacementNamed(context, '/home'))
        .catchError((error) {
      if (error is Error) {
        ErrorDialog.show(context, error);
      }
    });
  }
}
