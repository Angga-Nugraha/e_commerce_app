part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FetchAllFavorite extends FavoriteEvent {}

class AddToFavorite extends FavoriteEvent {
  final Product product;

  const AddToFavorite({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteFromFavorite extends FavoriteEvent {
  final Product product;

  const DeleteFromFavorite({required this.product});

  @override
  List<Object> get props => [product];
}

class CheckFavoriteStatus extends FavoriteEvent {
  final int id;

  const CheckFavoriteStatus({required this.id});

  @override
  List<Object> get props => [id];
}
