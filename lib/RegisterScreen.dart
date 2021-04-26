import 'package:flutter/material.dart';
import 'package:wattcopy/common/WattcopyScaffold.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WattcopyScaffold(
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
							buildField("Email", _emailController, () {}),
							buildField("Nome de usuário", _usernameController, () {}),
							buildField("senha", _passwordController, () {}, obscureText: true),
							SizedBox(height: 24),
							SizedBox(
								width: double.infinity,
								child: ElevatedButton(
									onPressed: () {},
									child: Text("Register")
								),
							),
						],
					),
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
