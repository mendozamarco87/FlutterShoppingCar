import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_car/models/cart_model.dart';
import 'package:shopping_car/models/cart_product_model.dart';
import 'package:shopping_car/models/product_model.dart';
import 'package:shopping_car/tools/extensions.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  
  final SharedPreferences _sharedPreferences;

  CartBloc(SharedPreferences sharedPreferences)
     : _sharedPreferences = sharedPreferences, super(CartLoading()) {
    on<CartStarted>(_onCartStarted);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartProductRemoved>(_onCartProductRemoved);
    on<CartProductUpdateQuantity>(_onCartProductUpdateQuantity);
  }

  static const String cartPrefKey = "Preferences.Cart";

  FutureOr<void> _onCartStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      emit(CartLoaded(cart: event.cart));

      _sharedPreferences.setString(cartPrefKey, event.cart.toJson());
    } catch (_) {}
  }

  FutureOr<void> _onCartProductAdded(
      CartProductAdded event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final cart = (state as CartLoaded).cart;
      final productCartExistent = cart.products
          .where((e) => e.productId == event.product.id)
          .firstOrNull;

      late final CartProduct cardProductToAdd;
      if (productCartExistent == null) {
        cardProductToAdd = CartProduct(cart: cart, product: event.product, quantity: 1);
        final cartUpdated = cart.copyWith(products: List.from(cart.products)..add(cardProductToAdd));
        emit(CartLoaded(cart: cartUpdated));
        _sharedPreferences.setString(cartPrefKey, cartUpdated.toJson());
      }
      
    }
  }

  FutureOr<void> _onCartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final cart = (state as CartLoaded).cart;
      final updatedCart = cart.copyWith(
          products: List.from(cart.products)
            ..removeWhere((e) => e.productId == event.product.id));

      emit(CartLoaded(cart: updatedCart));
      _sharedPreferences.setString(cartPrefKey, updatedCart.toJson());
    }
  }

  FutureOr<void> _onCartProductUpdateQuantity(CartProductUpdateQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final cart = (state as CartLoaded).cart;
      final index = cart.products.indexOf(event.cartProduct);

      if (index != -1) {
        if (event.newQuantity > 0) {
          final cardProductUpdated = cart.products[index].copyWith(
            quantity: event.newQuantity);
          final updatedCart = cart.copyWith(products: List.from(cart.products)..replaceRange(index, index+1, [cardProductUpdated]));
          emit(CartLoaded(cart: updatedCart));
          _sharedPreferences.setString(cartPrefKey, updatedCart.toJson());
        } else {
          add(CartProductRemoved(event.cartProduct.product));
        }
      }
    }
  }
}
