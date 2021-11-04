import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shopping_car/models/cart_product_model.dart';
import 'package:shopping_car/tools/extensions.dart';

import 'ShimmerPlaceholderLoading.dart';

class CartProductCard extends StatelessWidget {
  final CartProduct cartProduct;
  final void Function(CartProduct cartProduct)? onQuantityIncrement;
  final void Function(CartProduct cartProduct)? onQuantityDecrement;

  const CartProductCard({Key? key, required this.cartProduct, this.onQuantityDecrement, this.onQuantityIncrement})
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
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartProduct.product.price.toStringMoneyFormat(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (onQuantityDecrement != null) {
                            onQuantityDecrement!(cartProduct);
                          }
                        },
                      ),
                      Text(
                        cartProduct.quantity.toStringFormatted(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (onQuantityIncrement != null) {
                            onQuantityIncrement!(cartProduct);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
          SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
