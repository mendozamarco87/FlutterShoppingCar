part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class OrderStarted extends OrderEvent {

  final Cart cart;

  OrderStarted({
    required this.cart,
  });

  @override
  List<Object?> get props => [cart];
}

class UpdateOrder extends OrderEvent {

  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final double? subtotal;
  final double? discount;
  final double? total;
  final Cart? cart;

  UpdateOrder({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.cart,
    this.subtotal,
    this.discount,
    this.total,
  });

  @override
  List<Object?> get props => [name, email, phone, address, cart, subtotal, discount, total];
}

class SaveOrder extends OrderEvent {

  final Order order;

  SaveOrder({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}
