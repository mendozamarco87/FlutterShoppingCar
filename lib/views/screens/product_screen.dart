import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/models/product_model.dart';
import 'package:shopping_car/views/widgets/ShimmerPlaceholderLoading.dart';
import 'package:shopping_car/tools/extensions.dart';
import 'package:shopping_car/views/widgets/wigets_utils.dart';

import 'cart_screen.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/product";
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },)
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 400,
            child: OptimizedCacheImage(
              imageUrl: product.imageUrl,
              placeholder: (context, url) => ShimmerPlaceholderLoading(
                borderRadius: 16,
                enable: false,
              ),
              fit: BoxFit.cover,
              height: 500.0,
              width: 500.0,
              errorWidget: (context, s, d) => Icon(
                Icons.broken_image_outlined,
                size: 50,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  product.sku,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      "Precio:   ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      product.price.toStringMoneyFormat(),
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            height: 70,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                return TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Adicionar al Carrito".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.add_circle,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(CartProductAdded(product));
                    WidgetUtils.showSnackbarSuccess(
                        context, "Producto adicionado a tu carrito");
                  },
                );
                } else {
                  return Container();
                }
              },
            )),
      ),
    );
  }
}
