import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserService {
  Future<User?> register(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> forgotPassword(String email);
   Future<User?> googleLogin();

   Future<User?> logout();
}
