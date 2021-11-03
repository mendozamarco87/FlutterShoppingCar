part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {

  @override
  List<Object> get props => [];
}

class UpdateCategories extends CategoryEvent {

  final List<Category> categories;

  UpdateCategories(this.categories);

  @override
  List<Object> get props => [categories];
}