import 'package:flutter/material.dart';
import 'package:shopping_car/views/screens/error_screen.dart';
import 'package:shopping_car/views/screens/home_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
}
