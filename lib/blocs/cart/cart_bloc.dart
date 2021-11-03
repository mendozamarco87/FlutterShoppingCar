import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_car/models/cart_model.dart';
import 'package:shopping_car/models/cart_product_model.dart';
import 'package:shopping_car/models/product_model.dart';
import 'package:shopping_car/tools/extensions.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_onCartStarted);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartProductRemoved>(_onCartProductRemoved);
    on<CartProductUpdateQuantity>(_onCartProductUpdateQuantity);
  }

  void _onCartStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      emit(CartLoaded(cart: event.cart));
    } catch (_) {}
  }

  void _onCartProductAdded(
      CartProductAdded event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final cart = (state as CartLoaded).cart;
      final productCartExistent = cart.products
          .where((e) => e.productId == event.product.id)
          .firstOrNull;

      late final CartProduct cardProductToAdd;
      if (productCartExistent == null) {
        cardProductToAdd = CartProduct(cart: cart, product: event.product, quantity: 1);
        emit(CartLoaded(cart: cart.copyWith(products: List.from(cart.products)..add(cardProductToAdd))));
      }
      
    }
  }

  void _onCartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final cart = (state as CartLoaded).cart;
      final updatedCart = cart.copyWith(
          products: List.from(cart.products)
            ..removeWhere((e) => e.productId == event.product.id));

      emit(CartLoaded(cart: updatedCart));
    }
  }

  void _onCartProductUpdateQuantity(CartProductUpdateQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final cart = (state as CartLoaded).cart;
      final index = cart.products.indexOf(event.cartProduct);

      if (index != -1) {
        if (event.newQuantity < 1) {
          _onCartProductRemoved(CartProductRemoved(event.cartProduct.product), emit);
          return;
        }
        final cardProductUpdated = cart.products[index].copyWith(
            quantity: event.newQuantity);

        emit(CartLoaded(cart: cart.copyWith(products: List.from(cart.products)..replaceRange(index, index+1, [cardProductUpdated]))));
      }
    }
  }
}
