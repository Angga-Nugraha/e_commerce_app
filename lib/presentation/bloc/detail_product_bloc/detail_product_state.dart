part of 'detail_product_bloc.dart';

abstract class DetailProductState extends Equatable {
  const DetailProductState();

  @override
  List<Object> get props => [];
}

class DetailProductInitial extends DetailProductState {}

class ProductLoading extends DetailProductState {}

class ProductHasData extends DetailProductState {
  final Product product;

  const ProductHasData({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductHasError extends DetailProductState {
  final String message;

  const ProductHasError({required this.message});
  @override
  List<Object> get props => [message];
}
