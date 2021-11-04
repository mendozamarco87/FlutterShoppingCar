part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  
  @override
  List<Object> get props => [];
}

class OrdersLoading extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrdersLoaded extends OrdersState {

  final List<Order> orders;

  OrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrdersError extends OrdersState {

  @override
  List<Object> get props => [];
}