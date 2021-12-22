import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static navigateTo(String route) {
    return navigatorKey.currentState!.pushNamed(route);
  }

  static replaceTo(String route) {
    return navigatorKey.currentState!.pushReplacementNamed(route);
  }
}
