import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/blocs/category/category_bloc.dart';
import 'package:shopping_car/blocs/order/order_bloc.dart';
import 'package:shopping_car/blocs/orders/orders_bloc.dart';
import 'package:shopping_car/blocs/product/product_bloc.dart';
import 'package:shopping_car/config/app_router.dart';
import 'package:shopping_car/models/cart_model.dart';
import 'package:shopping_car/repositories/category/category_repository.dart';
import 'package:shopping_car/repositories/order/order_repository.dart';
import 'package:shopping_car/repositories/product/product_repository.dart';
import 'package:shopping_car/views/resources/themes.dart';

import 'views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseFirestore = FirebaseFirestore.instance;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CartBloc()
              ..add(CartStarted(
                  Cart(id: UniqueKey().toString(), status: "Pendiente")))),
        BlocProvider(
            create: (_) => CategoryBloc(
                categoryRespository:
                    CategoryRespository(firebaseFirestore: firebaseFirestore))
                  ..add(LoadCategories())),
        BlocProvider(
            create: (_) => ProductBloc(
                productRespository: 
                    ProductRespository(firebaseFirestore: firebaseFirestore))
                  ..add(LoadProducts())),
        BlocProvider(
            create: (context) => OrderBloc(
                orderRepository: OrderRepository(firebaseFirestore: firebaseFirestore), 
                cartBloc: context.read<CartBloc>())),
        BlocProvider(create: (_) => OrdersBloc(
                orderRepository: OrderRepository(firebaseFirestore: firebaseFirestore))
                ..add(LoadOrders()))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Shopping Cart Demo',
          theme: Themes.appTheme,
          darkTheme: Themes.appDarkTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
          builder: (context, widget) => ResponsiveWrapper.builder(widget,
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],)),
    );
  }
}
