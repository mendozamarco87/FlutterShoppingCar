import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shopping_car/models/product_model.dart';
import 'base_product_repository.dart';

class ProductRespository implements BaseProductRespository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRespository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  @override
  Stream<List<Product>> getAll() {
    return _firebaseFirestore
        .collection("products")
        .snapshots()
        .map((snap) => snap.docs.map((e) => Product.fromSnapshot(e)).toList());
  }
}
