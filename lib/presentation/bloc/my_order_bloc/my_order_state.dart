part of 'my_order_bloc.dart';

abstract class MyOrderState extends Equatable {
  const MyOrderState();

  @override
  List<Object> get props => [];
}

class MyOrderInitial extends MyOrderState {}

class MyOrderLoading extends MyOrderState {}

class MyOrderHasData extends MyOrderState {
  final List<Cart> result;

  const MyOrderHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class OrderSuccessState extends MyOrderState {
  final String result;

  const OrderSuccessState({required this.result});

  @override
  List<Object> get props => [result];
}

class MyOrderHasError extends MyOrderState {
  final String message;

  const MyOrderHasError({required this.message});

  @override
  List<Object> get props => [message];
}
