import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final loginTypes = await _firebaseAuth
            .fetchSignInMethodsForEmail(email)
            .timeout(Duration(seconds: 3));
        //!  como fazer para esperar um tempo para rodar

        print('LOGINTYPES com e.code = email-already-in-use --> $loginTypes');
        if (loginTypes.contains('password')) {
          print('LOGINTYPES.contains(password) --> $loginTypes');
          throw AuthException(
              message: 'E-mail já utilizado, por favor escolha outro e-mail');
        } else {
          print('LOGINTYPES ELSE .contains(password) --> $loginTypes');
          throw AuthException(
              message:
                  'Você se cadastrou no TodoList pelo Google, por favor utilize ele para entrar');
        }
      } else {
        print('e.code != email-already-in-use ==>> $e');
        throw AuthException(
            message: e.message ?? "Erro ao registrar o usuário!");
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar o Login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        throw AuthException(message: 'Login ou senha inválidos!');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar o Login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastro realizado com o Google, não pode ser resetada a senha');
      } else {
        throw AuthException(message: 'E-mail não cadastrado');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: 'Erro ao resetar senha');
    }
  }
}
