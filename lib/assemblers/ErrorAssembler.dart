
  
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:historium/errors/Error.dart';

const configFileName = "config/errorMessages.json";

class ErrorAssembler {

  static final _instance = ErrorAssembler.internal();
  static Map _errors = {};
  static bool _initialized = false;
  

  ErrorAssembler.internal();

  factory ErrorAssembler() => _instance;
  
  Future<String> loadConfig() async {
    return rootBundle.loadString(configFileName); 
  }

  Future<Map> get errors async {
    String file = await loadConfig();
    file = await loadConfig();

    if(!_initialized) {
      _errors = json.decode(file);
      _initialized = true;
    }
    
    return _errors;
  }

  Future<Error> toError(FirebaseAuthException exception) async {
    Map errorInfo = (await this.errors)[exception.code] ?? {
      "title": "Erro desconhecido",
      "message": "Um erro desconhecido ocorreu, tente novemente mais tarde."
    };

    return Error(
      errorInfo['title'],
      errorInfo['message']
    );
  }

}