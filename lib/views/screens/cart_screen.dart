import 'package:flutter/material.dart';
import 'package:shopping_car/dummy/data_dummy.dart';
import 'package:shopping_car/models/product_model.dart';
import 'package:shopping_car/views/widgets/cart_product_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/Cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CartProductCard(product: DataDummy.products[0]),
            CartProductCard(product: DataDummy.products[1]),
            Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:", style: Theme.of(context).textTheme.headline5,),
                  Text("0.00", style: Theme.of(context).textTheme.headline5,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

