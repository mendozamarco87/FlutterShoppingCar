import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/models/cart_model.dart';
import 'package:shopping_car/models/order_model.dart';
import 'package:shopping_car/repositories/order/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  final CartBloc _cartBloc;
  StreamSubscription? _orderSubscription;
  StreamSubscription? _cartSubscription;


  OrderBloc({
    required OrderRepository orderRepository,
    required CartBloc cartBloc
  })  : _orderRepository = orderRepository,
        _cartBloc = cartBloc,
        super(cartBloc.state is CartLoaded? OrderLoaded(
          name: "", 
          email: "", 
          phone: "", 
          address: "", 
          cart: (cartBloc.state as CartLoaded).cart, 
          subtotal: (cartBloc.state as CartLoaded).cart.subtotal,
          discount: (cartBloc.state as CartLoaded).cart.total, 
          total: (cartBloc.state as CartLoaded).cart.discount) : OrderLoading()) {

      on<OrderStarted>(_onOrderStarted);
      on<UpdateOrder>(_onUpdateOrder);
      on<SaveOrder>(_onSaveOrder);

      _cartSubscription = cartBloc.stream.listen((state) {
        if (state is CartLoaded) {
          add(UpdateOrder(cart: state.cart));
        }
      });
  }

  FutureOr<void> _onOrderStarted(OrderStarted event, Emitter<OrderState> emit) async {
    if ((state is OrderLoaded) == false) {
      emit(OrderLoading());
      try {
        await Future.delayed(Duration(seconds: 1));
        emit(OrderLoaded(
            name: "", 
            email: "", 
            phone: "", 
            address: "", 
            cart: event.cart, 
            subtotal: event.cart.subtotal,
            discount: event.cart.total, 
            total: event.cart.discount
        ));
      } catch (_) {
        emit(OrderError());
      }
    }
  }

  FutureOr<void> _onUpdateOrder(UpdateOrder event, Emitter<OrderState> emit) {
    if (state is OrderLoaded) {
      final orderLoaded = (state as OrderLoaded);
      emit(OrderLoaded(
        name: event.name ?? orderLoaded.name, 
        email: event.email ?? orderLoaded.email, 
        phone: event.phone ?? orderLoaded.phone, 
        address: event.address ?? orderLoaded.address, 
        cart: event.cart ?? orderLoaded.cart,
        subtotal: event.subtotal ?? orderLoaded.subtotal, 
        discount: event.discount ?? orderLoaded.discount, 
        total: event.total ?? orderLoaded.total, 
      ));
    }
  }

  FutureOr<void> _onSaveOrder(SaveOrder event, Emitter<OrderState> emit) async {
    _orderSubscription?.cancel();
    if (state is OrderLoaded) {
      try {
        emit(OrderLoading());
        await _orderRepository.saveOrder(event.order);
        emit(OrderSaved(order: event.order));

        final newCart = Cart(id: UniqueKey().toString(), status: "Pendiente");
        _cartBloc.add(CartStarted(newCart));

      } catch (_) {
        emit(OrderError());
      }
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}

