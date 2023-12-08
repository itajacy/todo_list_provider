import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider2.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Selector<AuthProvider2, String>(
          selector: (context, authProvider) =>
              authProvider.user?.displayName ?? 'Não informado',
          builder: (_, value, __) {
            return Text(
              'E aí, $value!',
              style: context.textTheme.headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            );
          },
        ),
      ],
    );
  }
}
