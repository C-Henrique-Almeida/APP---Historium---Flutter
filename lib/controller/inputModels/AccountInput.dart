import 'package:historium/controller/inputModels/UserInput.dart';

class AccountInput {

  String email;
  String password;
  
  UserInput userInput;

  AccountInput();

  factory AccountInput.empty() {
    final accountInput = AccountInput();

    accountInput.email = '';
    accountInput.password = '';

    accountInput.userInput = UserInput.empty();

    return accountInput;
  }

  @override
  String toString() {
    return '{email: $email, password: $password, userInput: ${userInput.toString()}';
  }
  
}