part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartHasdata extends CartState {
  final List<Product> result;

  const CartHasdata({required this.result});

  @override
  List<Object> get props => [result];
}

class CartHasError extends CartState {
  final String message;

  const CartHasError({required this.message});

  @override
  List<Object> get props => [message];
}

class CartAddedState extends CartState {
  final String message;

  const CartAddedState({required this.message});

  @override
  List<Object> get props => [message];
}

class CartRemoveState extends CartState {
  final String message;

  const CartRemoveState({required this.message});

  @override
  List<Object> get props => [message];
}
