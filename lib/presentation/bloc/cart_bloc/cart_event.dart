part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GettingAllcart extends CartEvent {}

class AddItemToCart extends CartEvent {
  final Product product;

  const AddItemToCart({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveItemToCart extends CartEvent {
  final Product product;

  const RemoveItemToCart({required this.product});

  @override
  List<Object> get props => [product];
}
