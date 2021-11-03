import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/views/widgets/cart_product_card.dart';
import 'package:shopping_car/tools/extensions.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/Cart";

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
              return _buildCartProductList(context, state);
            } else {
              return Text("Something went wrong");
            }
          },
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
                      onQuantityDecrement: (cartProduct) =>context
                          .read<CartBloc>()
                          .add(CartProductUpdateQuantity(
                              cartProduct, cartProduct.quantity - 1),));
                }),
          ),
          Divider(
            thickness: 2,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal:",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      state.cart.total.toStringMoneyFormat(),
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Descuento:",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      0.00.toStringMoneyFormat(),
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      state.cart.total.toStringMoneyFormat(),
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
