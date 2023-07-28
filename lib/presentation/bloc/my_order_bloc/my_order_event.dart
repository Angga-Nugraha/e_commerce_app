part of 'my_order_bloc.dart';

abstract class MyOrderEvent extends Equatable {
  const MyOrderEvent();

  @override
  List<Object> get props => [];
}

class FetchAllOrderCart extends MyOrderEvent {
  final int userId;

  const FetchAllOrderCart({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CreateOrder extends MyOrderEvent {
  final Cart cart;

  const CreateOrder({required this.cart});

  @override
  List<Object> get props => [cart];
}
