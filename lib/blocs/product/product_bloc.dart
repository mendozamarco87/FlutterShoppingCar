import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_car/models/product_model.dart';
import 'package:shopping_car/repositories/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRespository _productRespository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRespository productRespository})
      : _productRespository = productRespository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }

  FutureOr<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) {
    _productSubscription?.cancel();
    _productSubscription = _productRespository.getAll().listen((products) {
      add(UpdateProducts(products));
    });
  }

  FutureOr<void> _onUpdateProducts(
      UpdateProducts event, Emitter<ProductState> emit) {
        emit(ProductLoaded(event.products));
  }
}
