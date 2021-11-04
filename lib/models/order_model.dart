import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'cart_product_model.dart';

class Order extends Equatable {
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String customerAddress;
  final double subtotal;
  final double discount;
  final double total;
  final String status;
  final List<CartProduct> detail;

  Order({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerAddress,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.status,
    required this.detail,
  });

  @override
  List<Object?> get props => [
        customerName,
        customerEmail,
        customerPhone,
        customerAddress,
        subtotal,
        discount,
        total,
        status
      ];

  

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'subtotal': subtotal,
      'discount': discount,
      'total': total,
      'status': status,
      'detail': detail.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      customerName: map['customerName'],
      customerEmail: map['customerEmail'],
      customerPhone: map['customerPhone'],
      customerAddress: map['customerAddress'],
      subtotal: map['subtotal'],
      discount: map['discount'],
      total: map['total'],
      status: map['status'],
      detail: List<CartProduct>.from(map['detail']?.map((x) => CartProduct.fromMap(x))),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'subtotal': subtotal,
      'discount': discount,
      'total': total,
      'status': status,
      'detail': detail.map((x) => {
        'productName': x.product.name,
        'productPrice': x.product.price,
        'productSku': x.product.sku,
        'quantity': x.quantity,
      }).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
