import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static String currentPage = '';

/*   String get getCurrentPage => currentPage; */

  static navigateTo(String route) {
    currentPage = route;
    return navigatorKey.currentState!.pushNamed(route);
  }

  static replaceTo(String route) {
    return navigatorKey.currentState!.pushReplacementNamed(route);
  }
}
