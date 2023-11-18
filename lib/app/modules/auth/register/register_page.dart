import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text('Cadastro',
                style: TextStyle(fontSize: 12, color: context.primaryColor)),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: Form(

        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * .50,
              child: FittedBox(
                //! caso a tela seja menor a imagem irá diminuir junto
                child: TodoListLogo(),
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Form(
                child: Column(
                  children: [
                    TodoListField(label: 'E-mail'),
                    SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      label: 'Senha',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      label: 'Confirma Senha',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Salvar'),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
