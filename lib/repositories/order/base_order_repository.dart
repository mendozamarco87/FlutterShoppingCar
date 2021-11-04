import 'dart:async';

import 'package:shopping_car/models/order_model.dart';

abstract class BaseOrderRepository {
  FutureOr<void> saveOrder(Order order);
}