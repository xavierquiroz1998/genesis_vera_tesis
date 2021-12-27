import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration(
      {required String hint, required String label, required IconData icon}) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey));
  }

  static InputDecoration formInputDecoration(
      {required String hint, required String label, required IconData icon}) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
        isDense: true,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey));
  }
}
