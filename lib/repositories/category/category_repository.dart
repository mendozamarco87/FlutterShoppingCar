import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shopping_car/models/category_model.dart';
import 'base_category_repository.dart';

class CategoryRespository implements BaseCategoryRespository {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRespository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  @override
  Stream<List<Category>> getAll() {
    return _firebaseFirestore
        .collection("categories")
        .snapshots()
        .map((snap) => snap.docs.map((e) => Category.fromSnapshot(e)).toList());
  }
}
