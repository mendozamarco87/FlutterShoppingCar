import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Category(
      {required this.id, required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [id, name, imageUrl];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    return Category(
      id: snapshot.id,
      name: snapshot['name'],
      imageUrl: snapshot['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));
}
