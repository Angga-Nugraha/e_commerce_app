part of 'category_product_bloc.dart';

abstract class CategoryProductEvent extends Equatable {
  const CategoryProductEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryProduct extends CategoryProductEvent {
  final String query;

  const FetchCategoryProduct({required this.query});

  @override
  List<Object> get props => [query];
}
