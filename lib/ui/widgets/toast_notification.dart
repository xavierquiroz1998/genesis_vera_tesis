import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastNotificationView {
  static messageDanger(String _message) {
    Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "red",
    );
  }

  static messageAccess(String _message) {
    Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: 'rgb(25,33,255)',
    );
  }

  static messageWarning(String _message) {
    Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "orange",
    );
  }
}
