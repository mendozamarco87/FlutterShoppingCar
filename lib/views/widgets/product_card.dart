import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shopping_car/models/product_model.dart';
import 'package:shopping_car/views/resources/colors.dart';

import 'ShimmerPlaceholderLoading.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide.none, borderRadius: BorderRadius.circular(16)),
        child: Stack(
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
                height: 1000.0,
                width: 1000.0,
                errorWidget: (context, s, d) => Icon(
                  Icons.broken_image_outlined,
                  size: 50,
                ),
              ),
            ),
            Positioned.fill(
              top: null,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colorss.shadow,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text(
                      product.price,
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: IconButton(
                icon: Icon(Icons.add_circle, size: 36, color: Theme.of(context).colorScheme.secondary,),
                onPressed: (){
                  
                },),)
          ],
        ),
      ),
    );
  }
}
