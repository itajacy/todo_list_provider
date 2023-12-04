import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/app_widget.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider2.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository_impl.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:todo_list_provider/app/services/user/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (context) => SqliteMigrationFactory(),
          //! não será preguiçoso, executará e criará a instancia do sqlite na primeira vez
          //! criando banco de dados, executando as migrations por isso deve ficar como "false"
          lazy: false,
        ),
        //! o context.read() buscando do Provider a instancia do firebaseAuth
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(firebaseAuth: context.read()),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider2(
              firebaseAuth: context.read(), userService: context.read())
            ..loadListener(),
          lazy: false,
        ),
      ],
      child: AppWidget(),
    );
  }
}
