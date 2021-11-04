import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_car/blocs/orders/orders_bloc.dart';
import 'package:shopping_car/views/widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = "/orders";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Ordenes"),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(child: CircularProgressIndicator(),);
          } else if (state is OrdersLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: state.orders[index]);
                }),
            );
          } else {
            return Center(child: Text("Something went wrong"),);
          }
        },
      ),
    );
  }
}
