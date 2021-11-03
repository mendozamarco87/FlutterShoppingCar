import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_car/dummy/data_dummy.dart';
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
        title: Text("Shopping Cart"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CarouselSlider(
              items: DataDummy.categories
                  .map((e) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ProductsByCategoryScreen.routeName, arguments: e);
                    },
                    child: CategoryCard(
                          category: e,
                        ),
                  ))
                  .toList(),
              options: CarouselOptions(
                aspectRatio: 2,
                viewportFraction: 0.5,
                enlargeCenterPage: false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SectionTitle(title: "Todos los productos")),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ProductCard(product: DataDummy.products[index]);
              },
              childCount: DataDummy.products.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.0),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "MyCart",
        onPressed: () => {
          Navigator.pushNamed(context, CartScreen.routeName)
        }, 
        label: Text("My Cart"),
        icon: Icon(Icons.shopping_cart_outlined),
        backgroundColor: Theme.of(context).colorScheme.primary,),
    );
  }
}
