import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_car/models/category_model.dart';
import 'package:shopping_car/repositories/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRespository _categoryRespository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRespository categoryRespository})
      : _categoryRespository = categoryRespository,
        super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }

  FutureOr<void> _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRespository.getAll().listen((categories) {
      add(UpdateCategories(categories));
    });
  }

  FutureOr<void> _onUpdateCategories(
      UpdateCategories event, Emitter<CategoryState> emit) {
        emit(CategoryLoaded(event.categories));
  }
}
