import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  final String label;

  TodoListField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
