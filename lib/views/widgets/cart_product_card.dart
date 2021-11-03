import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shopping_car/models/product_model.dart';

import 'ShimmerPlaceholderLoading.dart';

class CartProductCard extends StatelessWidget {
  final Product product;

  const CartProductCard({Key? key, required this.product}) : super(key: key);

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
              imageUrl: product.imageUrl,
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
                product.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "\$${product.price}",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )),
          SizedBox(
            width: 12,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle),
                color: Theme.of(context).accentColor,
                onPressed: () {},
              ),
              Text(
                "1",
                style: Theme.of(context).textTheme.headline5,
              ),
              IconButton(
                icon: Icon(Icons.add_circle),
                color: Theme.of(context).accentColor,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
