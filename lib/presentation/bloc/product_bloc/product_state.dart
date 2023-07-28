part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductHasData extends ProductState {
  final List<Product> listProduct;
  final List<Product> topRatedProduct;
  final List<String> allCategory;

  const ProductHasData({
    required this.listProduct,
    required this.topRatedProduct,
    required this.allCategory,
  });

  @override
  List<Object> get props => [listProduct, topRatedProduct, allCategory];
}

class ProductHasError extends ProductState {
  final String message;

  const ProductHasError({required this.message});
  @override
  List<Object> get props => [message];
}
