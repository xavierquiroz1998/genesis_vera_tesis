import 'package:flutter/material.dart';

class SideMenuProvider extends ChangeNotifier {
  static late AnimationController menuController;
  static bool menuOpen = false;

  static Animation<double> movimiento = Tween<double>(begin: -200, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() {
    menuOpen = true;
    menuController.forward();
  }

  static void closeMenu() {
    menuOpen = false;
    menuController.reverse();
  }

  static void toggleMenu() {
    (menuOpen) ? menuController.reverse() : menuController.forward();
    menuOpen = !menuOpen;
  }
}
