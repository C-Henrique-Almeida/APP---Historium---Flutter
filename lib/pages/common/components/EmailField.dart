import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final controller;

  EmailField({this.controller});

  @override
  _EmailFieldState createState() => _EmailFieldState(controller: controller);
}

class _EmailFieldState extends State<EmailField> {
  final controller;

  _EmailFieldState({this.controller}) : super();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if(value.isEmpty) return 'Esse campo não pode estar vazio.';
        return null;
      },
      autocorrect: true,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 20
      ),
      decoration: InputDecoration(
        hintText: 'E-mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))
        )
      ),
    );
  }
}