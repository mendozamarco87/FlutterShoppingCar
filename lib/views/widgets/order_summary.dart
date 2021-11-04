
import 'package:flutter/material.dart';
import 'package:shopping_car/tools/extensions.dart';

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double discount;
  final double total;

  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.discount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal:",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                total.toStringMoneyFormat(),
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Descuento:",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                discount.toStringMoneyFormat(),
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                total.toStringMoneyFormat(),
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ],
      ),
    );
  }
}