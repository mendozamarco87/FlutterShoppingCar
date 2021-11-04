import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shopping_car/models/order_model.dart';
import 'package:shopping_car/repositories/order/base_order_repository.dart';

class OrderRepository implements BaseOrderRepository {
  
  final FirebaseFirestore _firebaseFirestore;

  OrderRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;
  
  @override
  Future<void> saveOrder(Order order) {
    return _firebaseFirestore.collection("orders").add(order.toDocument());
  }

}
