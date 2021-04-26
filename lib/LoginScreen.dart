import 'package:flutter/material.dart';
import 'package:wattcopy/common/WattcopyScaffold.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WattcopyScaffold(
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
								buildField("Nome de usuário", _usernameController, () {}),
								buildField("Senha", _passwordController, () {}, obscureText: true),
								SizedBox(height: 24),
								Container(
									width: double.infinity,
									child: ElevatedButton(
										onPressed: () {},
										child: Text("Login")
									),
								)
							],
						),
					)
				),
      ),
    );
  }

  Widget buildField(
		String label, 
		TextEditingController controller,
		Function onTextChange,
		{bool obscureText = false}
	) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          labelText: label,
        ),
        style: TextStyle(fontSize: 25.8, color: Colors.white),
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}
