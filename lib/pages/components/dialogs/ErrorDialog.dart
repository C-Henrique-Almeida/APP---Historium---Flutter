import 'package:flutter/material.dart';
import 'package:historium/errors/Error.dart';

class ErrorDialog extends StatelessWidget {
  final Error _error;

  ErrorDialog(this._error);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_error.title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SingleChildScrollView(
        child: Text(_error.message),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Ok')),
      ],
    );
  }

  static void show(BuildContext context, Error error) {
    showDialog(
      context: context,
      builder: (BuildContext _context) => ErrorDialog(error),
    );
  }
}