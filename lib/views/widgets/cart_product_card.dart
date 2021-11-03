import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/models/cart_product_model.dart';

import 'ShimmerPlaceholderLoading.dart';

class CartProductCard extends StatelessWidget {
  final CartProduct cartProduct;

  const CartProductCard({Key? key, required this.cartProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
          side: BorderSide.none, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: OptimizedCacheImage(
              imageUrl: cartProduct.product.imageUrl,
              placeholder: (context, url) => ShimmerPlaceholderLoading(
                borderRadius: 16,
                enable: false,
              ),
              fit: BoxFit.cover,
              height: 120.0,
              width: 150.0,
              errorWidget: (context, s, d) => Icon(
                Icons.broken_image_outlined,
                size: 50,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartProduct.product.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "\$${cartProduct.product.price.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )),
          SizedBox(
            width: 12,
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductUpdateQuantity(cartProduct, cartProduct.quantity - 1));
                    },
                  ),
                  Text(
                    "${cartProduct.quantity}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductUpdateQuantity(cartProduct, cartProduct.quantity + 1));
                    },
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
