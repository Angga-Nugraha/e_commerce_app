part of 'detail_product_bloc.dart';

abstract class DetailProductEvent extends Equatable {
  const DetailProductEvent();

  @override
  List<Object> get props => [];
}

class FetchSingleProduct extends DetailProductEvent {
  final int id;

  const FetchSingleProduct({required this.id});

  @override
  List<Object> get props => [id];
}
