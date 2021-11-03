import 'package:shopping_car/models/product_model.dart';

abstract class BaseProductRespository {
  Stream<List<Product>> getAll();
}