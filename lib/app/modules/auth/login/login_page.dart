import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      successCallback: (notifier, listenerInstance) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: ((context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.minWidth),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  TodoListLogo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TodoListField(
                            label: 'E-mail',
                            controller: _emailEC,
                            focusNode: _emailFocus,
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                          ),
                          SizedBox(height: 20),
                          TodoListField(
                            label: 'Senha',
                            obscureText: true,
                            controller: _passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatório'),
                              Validatorless.min(6,
                                  'Senha deve conter pelo menos 6 caracteres'),
                            ]),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (_emailEC.text.isNotEmpty) {
                                    // RecuperarSenha
                                  } else {
                                    _emailFocus.requestFocus();
                                    Messages.of(context).showError(
                                        'Digite um e-mail para recuperar sua senha');
                                  }
                                },
                                child: Text('Esqueceu sua senha?'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final formValid =
                                      _formkey.currentState?.validate() ??
                                          false;
                                  if (formValid) {
                                    final email = _emailEC.text;
                                    final password = _passwordEC.text;
                                    context
                                        .read<LoginController>()
                                        .login(email, password);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Login'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF0F3F7),
                        border: Border(
                            top: BorderSide(
                          width: 2,
                          color: Colors.grey.withAlpha(50),
                        )),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          SignInButton(
                            Buttons.google,
                            elevation: 4.0,
//! O texto "Continue com o Google", não cabe estoura em 12px
                            text: 'Cont. com o Google',
                            padding: const EdgeInsets.all(5),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            onPressed: () {},
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Não tem conta'),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: Text('Cadastre-se'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}
