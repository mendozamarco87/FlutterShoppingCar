import 'cart_model.dart';
import 'product_model.dart';

class CartProduct {
  final Product product;
  final Cart cart;
  final double quantity;

  CartProduct({
    required this.product,
    required this.cart,
    required this.quantity,
  });

  String get productId => product.id;
  String get cartId => cart.id;

  CartProduct copyWith({
    Product? product,
    Cart? cart,
    double? quantity,
  }) {
    return CartProduct(
      product: product ?? this.product,
      cart: cart ?? this.cart,
      quantity: quantity ?? this.quantity,
    );
  }
}
