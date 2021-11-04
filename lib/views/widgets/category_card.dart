import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shopping_car/models/category_model.dart';

import 'ShimmerPlaceholderLoading.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
          padding: EdgeInsets.all(20.0),
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor)
          ),
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
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                  errorWidget: (context, s, d) => Icon(
                    Icons.broken_image_outlined,
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(category.name, style: Theme.of(context).textTheme.caption,)
      ],
    );
  }
}
