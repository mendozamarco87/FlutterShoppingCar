part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {

  final List<Category> categories;

  CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {

  @override
  List<Object> get props => [];
}
