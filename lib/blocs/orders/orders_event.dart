part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrdersEvent {

  @override
  List<Object> get props => [];
}

class UpdateOrders extends OrdersEvent {

  final List<Order> orders;

  UpdateOrders(this.orders);

  
  @override
  List<Object> get props => [];
}