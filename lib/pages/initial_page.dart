import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/pages/common/components/EmailField.dart';
import 'package:historium/pages/common/components/PasswordField.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _formState = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  void login() async {
    if(!_formState.currentState.validate()) return Future.error(
      'Um ou mais campos não foram preenchidos corretamente'
    );

    try{
      await firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (error) {
      String title;
      String message;

      print(error.code);

      switch(error.code) {
        case 'user-not-found':
        case 'wrong-password':
          title = 'Erro no login';
          message = 'Email ou senha incorretos.';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Historium',
          style: GoogleFonts.revalia(
            shadows: <Shadow> [
              Shadow(
                blurRadius: 4,
                offset: Offset(0, 4)
              ),
            ],
            fontSize: 48,
            color: Colors.black,
          ),
        ),  
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Text(
            'Compartilhando\nhistórias',
            textAlign: TextAlign.center,
            style: GoogleFonts.rokkitt(
              fontSize: 28,
              color: Colors.black
            ),
          ),  
        ),              
        toolbarHeight: 160,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
        SizedBox(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              constraints: BoxConstraints(
                minHeight:
                  MediaQuery.of(context).size.height - 
                  Scaffold.of(context).appBarMaxHeight,
              ),
              child: Form(
                key: _formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        EmailField(
                          controller: _emailController, 
                        ),
                        SizedBox(height: 12,),
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
                      
                          onPressed: () => Navigator.pushNamed(context, '/reset-password'),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget> [
                        ElevatedButton(
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
                              borderRadius: BorderRadius.all(Radius.circular(50))
                            )),
                            
                          ),
                          onPressed: login,
                          child: Text('Login'),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'ou',
                          style: GoogleFonts.rokkitt(fontSize: 22),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
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
                              borderRadius: BorderRadius.all(Radius.circular(50))
                            )),
                          ),
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              Image.asset('assets/icon-google.png'),
                              SizedBox(width: 10,),
                              Text('Logar com o google'),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Ainda não se cadastrou?',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          child: Text(
                            'Registre-se aqui',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/register'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ) 
          ),
        ),
      ),
    );
  }
}