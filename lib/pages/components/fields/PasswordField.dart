import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final controller;
  PasswordField({this.controller});

  @override
  _PasswordFieldState createState() => _PasswordFieldState(controller: controller);
}

class _PasswordFieldState extends State<PasswordField> {
  final controller;

  _PasswordFieldState({this.controller}) : super();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value.length <= 6) return 'A senha deve ter mais de 6 caracteres.';
        return null;
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      style: TextStyle(
        fontSize: 20
      ),
      decoration: InputDecoration(
        hintText: 'Senha',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))
        )
      ),
    );
  }
}