import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_car/blocs/product/product_bloc.dart';
import 'package:shopping_car/models/category_model.dart';
import 'package:shopping_car/views/widgets/product_card.dart';

import 'cart_screen.dart';
import 'product_screen.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  static const routeName = "/ProductsByCategory";
  final Category category;

  const ProductsByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            final _productListByCategory =
              state.products.where((e) => e.categoryId == category.id).toList();

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.0),
                itemCount: _productListByCategory.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ProductCard(product: _productListByCategory[index]),
                    onTap: () {
                      Navigator.pushNamed(context, ProductScreen.routeName, arguments: _productListByCategory[index]);
                    },);
                });
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "MiCarrito",
        onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
        label: Text("Mi Carrito"),
        icon: Icon(Icons.shopping_cart_outlined),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
