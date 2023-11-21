import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';

import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
     showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);

      // print('CONTEUDO DE user --> $user');
      // print('USER NÃO É NULO = ${user != null}');

      if (user != null) {
        // sucesso
        success();
        // print('sucesso = TRUE');
      } else {
        // erro
        setError('Erro ao registrar o usuário!');
      }
    } on AuthException catch (e) {
      setError(e.message);
      
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  @override
  String toString() =>
      'RegisterController(_userService: $_userService, error: $error, success: $success)';
}
