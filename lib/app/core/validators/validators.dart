
import 'package:flutter/material.dart';

class Validators {
  //! fu-private-contructor
  //!  criado um construtor privado, pois não queremos que esta classe seja instanciada
  Validators._();

  static FormFieldValidator compare(TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
      }
    };
  }
}