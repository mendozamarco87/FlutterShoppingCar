import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String sku;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [id, name, categoryId];
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      categoryId: map['categoryId'],
    );
  }

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
      id: snapshot.id,
      name: snapshot['name'],
      sku: snapshot['sku'],
      description: snapshot['description'],
      price: double.parse(snapshot['price'].toString()),
      imageUrl: snapshot['imageUrl'],
      categoryId: snapshot['categoryId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
