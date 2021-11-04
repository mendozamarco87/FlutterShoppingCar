part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoaded extends OrderState {
  final String name;
  final String email;
  final String phone;
  final String address;
  final double subtotal;
  final double discount;
  final double total;
  final Cart cart;
  final Order order;

  OrderLoaded({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.cart,
    required this.subtotal,
    required this.discount,
    required this.total,
  }) : order = Order(
            customerName: name,
            customerEmail: email,
            customerPhone: phone,
            customerAddress: address,
            subtotal: subtotal,
            discount: discount,
            total: total,
            status: cart.status,
            detail: cart.products);

  @override
  List<Object> get props => [name, email, phone, address, cart, subtotal, discount, total];
}

class OrderSaved extends OrderState {
  final Order order;

  OrderSaved({
    required this.order,
  });
  
  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {
  @override
  List<Object> get props => [];
}