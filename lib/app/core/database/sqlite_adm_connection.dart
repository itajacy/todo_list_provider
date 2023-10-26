import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

//! aqui com o "with" estamos fazendo um MIXIN da classe WidgetsBindingObserver
//! que servirá para criar um "observer" cuja ideia principal é saber quando
//! o usuário sair da tela do sistema por qualquer motivo, e conseguirmos sabendo disso
//! fechar a conexão ao banco de dados para evitar que o mesmo seja corrompido

class SqliteAdmConnection with WidgetsBindingObserver {
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch(state) {
      case AppLifecycleState.resumed:
        break;

      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }

 
}
