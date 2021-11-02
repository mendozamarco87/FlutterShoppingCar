import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shopping_car/models/category_model.dart';
import 'package:shopping_car/views/resources/colors.dart';

import 'ShimmerPlaceholderLoading.dart';
import 'box_inner_shadow.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: [
            OptimizedCacheImage(
              imageUrl: category.imageUrl,
              placeholder: (context, url) => ShimmerPlaceholderLoading(
                borderRadius: 16.0,
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
            BoxInnerShadow(
              bottomShadow: InnerShadow(
                  color: Colorss.shadow,
                  blurRadius: 15, 
                  size: 35
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                ),
              ))
          ],
        ),
      ),
    );
  }
}
