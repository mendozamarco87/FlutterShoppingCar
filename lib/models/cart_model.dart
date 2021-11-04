import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'cart_product_model.dart';

class Cart extends Equatable {
  final String id;
  final String status;
  final List<CartProduct> products;

  Cart({
    required this.id,
    required this.status,
    this.products = const []
  });

  double get subtotal => products.fold(0, (previousValue, element) => previousValue + element.product.price * element.quantity);
  double get discount => 0.0;
  double get total => subtotal - discount;


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

  @override
  List<Object?> get props => [id, status, products];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      status: map['status'],
      products: List<CartProduct>.from(map['products']?.map((x) => CartProduct.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
