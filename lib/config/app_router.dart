import 'package:flutter/material.dart';
import 'package:shopping_car/models/category_model.dart';
import 'package:shopping_car/views/screens/cart_screen.dart';
import 'package:shopping_car/views/screens/error_screen.dart';
import 'package:shopping_car/views/screens/home_screen.dart';
import 'package:shopping_car/views/screens/order_screen.dart';
import 'package:shopping_car/views/screens/products_by_category_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case ProductsByCategoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductsByCategoryScreen(category: settings.arguments as Category));
      case CartScreen.routeName:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case OrderScreen.routeName:
        return MaterialPageRoute(builder: (_) => OrderScreen());
      default:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
}
