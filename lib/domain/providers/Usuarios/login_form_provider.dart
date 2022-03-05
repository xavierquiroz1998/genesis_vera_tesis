import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool validateForm() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
