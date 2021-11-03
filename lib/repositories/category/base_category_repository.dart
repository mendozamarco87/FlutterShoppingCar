import 'package:shopping_car/models/category_model.dart';

abstract class BaseCategoryRespository {
  Stream<List<Category>> getAll();
}