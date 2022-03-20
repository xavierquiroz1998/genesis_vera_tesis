import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/*   String get getCurrentPage => currentPage; */

  static navigateTo(String route) {
    return navigatorKey.currentState!.pushNamed(route);
  }

  static replaceTo(String route) {
    return navigatorKey.currentState!.pushReplacementNamed(route);
  }
}
