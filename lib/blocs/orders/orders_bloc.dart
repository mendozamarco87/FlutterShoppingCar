import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_car/models/order_model.dart';
import 'package:shopping_car/repositories/order/order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {

  final OrderRepository _orderRepository;
  StreamSubscription? _ordersSubscription;

  OrdersBloc({required OrderRepository orderRepository}) 
    : _orderRepository = orderRepository, super(OrdersLoading()) {
    on<LoadOrders>(_onLoadOrders);
    on<UpdateOrders>(_onUpdateOrders);
  }

  FutureOr<void> _onLoadOrders(LoadOrders event, Emitter<OrdersState> emit) {
    _ordersSubscription?.cancel();
    _ordersSubscription = _orderRepository.getAll().listen((orders) {
      add(UpdateOrders(orders));
    });
  }

  FutureOr<void> _onUpdateOrders(UpdateOrders event, Emitter<OrdersState> emit) {
    emit(OrdersLoaded(event.orders));
  }
}
