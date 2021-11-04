import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/blocs/order/order_bloc.dart';
import 'package:shopping_car/views/screens/order_screen.dart';
import 'package:shopping_car/views/widgets/cart_product_card.dart';
import 'package:shopping_car/views/widgets/order_summary.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Carrito"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.cart.products.length == 0) {
                return Center(child: Text("Tu carrito esta vacío"));
              } else {
                return _buildCartProductList(context, state);
              }
            } else {
              return Text("Something went wrong");
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cart.products.length > 0) {
                return TextButton(
                  onPressed: () {
                    context.read<OrderBloc>().add(OrderStarted(cart: state.cart));
                    Navigator.pushNamed(context, OrderScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Crear Orden".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Icon(Icons.arrow_right_alt)
                    ],
                  ));
              } else {
                return TextButton(
                  onPressed: ()=> Navigator.pop(context), 
                  child: Text(
                        "Volver".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),);
              }
            },
          ),
        ),
      ),
    );
  }

  Padding _buildCartProductList(BuildContext context, CartLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: state.cart.products.length,
                itemBuilder: (context, index) {
                  return CartProductCard(
                      cartProduct: state.cart.products[index],
                      onQuantityIncrement: (cartProduct) => context
                          .read<CartBloc>()
                          .add(CartProductUpdateQuantity(
                              cartProduct, cartProduct.quantity + 1)),
                      onQuantityDecrement: (cartProduct) =>
                          context.read<CartBloc>().add(
                                CartProductUpdateQuantity(
                                    cartProduct, cartProduct.quantity - 1),
                              ));
                }),
          ),
          Divider(
            thickness: 2,
          ),
          OrderSummary(
            subtotal: state.cart.subtotal,
            discount: state.cart.discount,
            total: state.cart.total,
          ),
        ],
      ),
    );
  }
}
