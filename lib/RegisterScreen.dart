import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wattcopy/common/WattcopyScaffold.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void clearFields() {
    setState(() {
        _emailController.text = '';
        _usernameController.text = '';
        _passwordController.text = '';
    });
  }

  void registerUser() async {
    if(_formKey.currentState.validate()) {

      await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      )
      .then((userCredentials) {
          clearFields();
        }
      )
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
        }
      ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: WattcopyScaffold(
        caption: "Registrar",
        backButton: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildField(
                  "Email",
                  _emailController,
                  hintText: 'O email que deseja cadastrar...'
                ),
                buildField(
                  "Nome de usuário",
                  _usernameController,
                  hintText: 'O seu nome de usuário...'
                ),
                buildField(
                  "senha",
                  _passwordController,
                  hintText: 'A sua nova senha...',
                  obscureText: true
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: registerUser,
                    child: Text("Register")
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(
		String label,
		TextEditingController controller,
    {bool obscureText = false, String hintText = ''}
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
