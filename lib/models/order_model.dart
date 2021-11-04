import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_car/models/cart_model.dart';
import 'package:shopping_car/models/product_model.dart';

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
  final DateTime date;
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
    required this.date,
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
        status,
        date
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
      'date': date,
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
      date: map['date'],
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
      'date': date,
      'detail': detail.map((x) => {
        'productName': x.product.name,
        'productPrice': x.product.price,
        'productSku': x.product.sku,
        'quantity': x.quantity,
      }).toList(),
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    return Order(
      customerName: snapshot['customerName'],
      customerEmail: snapshot['customerEmail'],
      customerPhone: snapshot['customerPhone'],
      customerAddress: snapshot['customerAddress'],
      subtotal: snapshot['subtotal'],
      discount: snapshot['discount'],
      total: snapshot['total'],
      status: snapshot['status'],
      date: (snapshot['date'] as Timestamp).toDate() ,
      detail: List<CartProduct>.from(snapshot['detail']?.map((x) => CartProduct(
        product: Product(
          id: "", 
          name: x['productName'], 
          sku: x['productSku'], 
          description: "", 
          price: x['productPrice'], 
          imageUrl: "", 
          categoryId: ""),
        cart: Cart(id: snapshot.id, status: snapshot['status']),
        quantity: x['quantity']
      ))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
