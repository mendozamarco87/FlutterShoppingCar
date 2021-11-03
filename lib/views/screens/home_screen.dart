import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_car/blocs/category/category_bloc.dart';
import 'package:shopping_car/blocs/product/product_bloc.dart';
import 'package:shopping_car/views/screens/cart_screen.dart';
import 'package:shopping_car/views/screens/products_by_category_screen.dart';
import 'package:shopping_car/views/widgets/category_card.dart';
import 'package:shopping_car/views/widgets/product_card.dart';
import 'package:shopping_car/views/widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tienda Digital"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return CircularProgressIndicator();
              } else if (state is CategoryLoaded) {
                return _buildCategories(context, state);
              } else {
                return Container();
              }
            },
          )),
          SliverToBoxAdapter(child: SectionTitle(title: "Todos los productos")),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),),);
              } else if (state is ProductLoaded) {
                return _buildProducts(context, state);
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "MiCarrito",
        onPressed: () => {Navigator.pushNamed(context, CartScreen.routeName)},
        label: Text("Mi Carrito"),
        icon: Icon(Icons.shopping_cart_outlined),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  SliverGrid _buildProducts(BuildContext context, ProductLoaded state) {
    return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductCard(product: state.products[index]);
                  },
                  childCount: state.products.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.0),
              );
  }

  Widget _buildCategories(BuildContext context, CategoryLoaded state) {
    return Container(
      height: 150.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: CategoryCard(
                category: state.categories[index],
              ),
              onTap: () {
                Navigator.pushNamed(context, ProductsByCategoryScreen.routeName,
                    arguments: state.categories[index]);
              },
            );
          }),
    );
  }
}
