import 'package:shopping_car/models/cart_product_model.dart';

class Cart {
  final String id;
  final String status;
  final List<CartProduct> products;

  Cart({
    required this.id,
    required this.status,
    this.products = const []
  });

  double get total => products.fold(0, (previousValue, element) => previousValue + element.product.price * element.quantity);

  Cart copyWith({
    String? id,
    String? status,
    List<CartProduct>? products,
  }) {
    return Cart(
      id: id ?? this.id,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
