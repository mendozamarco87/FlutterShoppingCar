import 'package:flutter/material.dart';
import 'package:shopping_car/models/order_model.dart';
import 'package:shopping_car/tools/extensions.dart';
import 'package:shopping_car/views/resources/colors.dart';

class OrderCard extends StatelessWidget {

  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
          side: BorderSide.none, borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.date.toStringFormatLat(), style: Theme.of(context).textTheme.caption,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border.all(
                      color: order.status == "Pendiente"? Colorss.error : (order.status == "Completado"? Colorss.success : Theme.of(context).dividerColor))
                  ),
                  child: Text(order.status, style: Theme.of(context).textTheme.caption!.copyWith(
                    color: order.status == "Pendiente"? Colorss.error : (order.status == "Completado"? Colorss.success : Theme.of(context).dividerColor)
                  ),),
                )
              ],
            ),
          ],
        ),
        subtitle: 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Total:",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(width: 16,),
                Text(
                  order.total.toStringMoneyFormat(),
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Nombre:",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: 16,),
                  Text(
                    order.customerName,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Correo:",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: 16,),
                  Text(
                    order.customerEmail,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Teléfono:",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: 16,),
                  Text(
                    order.customerPhone,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Dirección:",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: 16,),
                  Text(
                    order.customerAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              ]),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
              child: Column(
                children: [
                  Divider(thickness: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Producto SKU", style: Theme.of(context).textTheme.bodyText1),
                      Text("Cantidad", style: Theme.of(context).textTheme.bodyText1),
                      Text("Precio", style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                  Divider(thickness: 2,),
                  Column(
                    children: order.detail.map((detail) => Row(
                      children: [
                        Expanded(flex: 3, child: Text(detail.product.sku)),
                        Expanded(child: Text(detail.quantity.toStringFormatted(), textAlign: TextAlign.right,)),
                        Expanded(flex: 2, child: Text(detail.product.price.toStringMoneyFormat(), textAlign: TextAlign.right,))
                      ],
                    )).toList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),);
  }
}