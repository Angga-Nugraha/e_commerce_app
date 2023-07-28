part of 'category_product_bloc.dart';

abstract class CategoryProductState extends Equatable {
  const CategoryProductState();

  @override
  List<Object> get props => [];
}

class CategoryProductInitial extends CategoryProductState {}

class CategoryLoading extends CategoryProductState {}

class CategoryHasData extends CategoryProductState {
  final List<Product> result;

  const CategoryHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class CategoryHasError extends CategoryProductState {
  final String message;

  const CategoryHasError({required this.message});
  @override
  List<Object> get props => [message];
}
