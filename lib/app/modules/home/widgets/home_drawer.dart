import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider2.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvider2, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://avatars.githubusercontent.com/u/1609975?s=200&v=4';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                ),
                Expanded(
                  child: Selector<AuthProvider2, String>(
                    selector: (context, authProvider) {
                      return authProvider.user?.displayName ?? 'não informado';
                    },
                    builder: (_, value, __) {
                      return Text(
                        value,
                        style: context.textTheme.subtitle2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Alterar Nome'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Alterar Nome'),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            final nameValue = nameVN.value;
                            if (nameValue.isEmpty) {
                              Messages.of(context)
                                  .showError('Nome Obrigatório');
                            } else {
                              // Loader.show(context);
                              await context
                                  .read<UserService>()
                                  .updateDisplayName(nameValue);
                              // Loader.hide();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text('Alterar')),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () => context.read<AuthProvider2>().logout(),
          ),
        ],
      ),
    );
  }
}
