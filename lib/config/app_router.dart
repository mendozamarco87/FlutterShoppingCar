import 'package:flutter/material.dart';
import 'package:shopping_car/models/category_model.dart';
import 'package:shopping_car/models/product_model.dart';
import 'package:shopping_car/views/screens/cart_screen.dart';
import 'package:shopping_car/views/screens/error_screen.dart';
import 'package:shopping_car/views/screens/home_screen.dart';
import 'package:shopping_car/views/screens/order_screen.dart';
import 'package:shopping_car/views/screens/orders_screen.dart';
import 'package:shopping_car/views/screens/product_screen.dart';
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
      case OrdersScreen.routeName:
        return MaterialPageRoute(builder: (_) => OrdersScreen());
      case ProductScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductScreen(product: settings.arguments as Product,));
      default:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
}
