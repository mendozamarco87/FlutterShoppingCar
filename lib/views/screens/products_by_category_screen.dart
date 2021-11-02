import 'package:flutter/material.dart';
import 'package:shopping_car/dummy/data_dummy.dart';
import 'package:shopping_car/models/category_model.dart';
import 'package:shopping_car/views/widgets/product_card.dart';

class ProductsByCategoryScreen extends StatelessWidget {

  static const routeName = "/ProductsByCategory";
  final Category category;

  const ProductsByCategoryScreen({Key? key, required this.category}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final _productListByCategory = CategoryDummy.products.where((e) => e.categoryId == category.id).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name),),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.0), 
                itemCount: _productListByCategory.length,
        itemBuilder: (context, index) {
          return ProductCard(product: _productListByCategory[index]);
        }),
    );
  }
}