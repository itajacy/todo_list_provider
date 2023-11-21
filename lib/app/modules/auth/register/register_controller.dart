import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
  error = null;
  success = false;
  notifyListeners();
  final user = await _userService.register(email, password);

  print('CONTEUDO DE user --> $user');
  print('USER NÃO É NULO = ${user != null}');

  if (user != null) {
    // sucesso
    success = true;
    print('sucesso = TRUE');
   
  } else {
    // erro
    error = 'Erro ao registrar o usuário!';
  }
} on AuthException catch (e) {
  error = e.message;
  notifyListeners();
} finally {

}
  }

  @override
  String toString() => 'RegisterController(_userService: $_userService, error: $error, success: $success)';
}
