part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FavoriteInitial extends FavoriteState {
  bool value;

  FavoriteInitial(this.value);

  @override
  List<Object> get props => [value];
}

class FavoriteLoading extends FavoriteState {}

class ListFavoriteProduct extends FavoriteState {
  final List<Product> result;

  const ListFavoriteProduct({required this.result});

  @override
  List<Object> get props => [result];
}

class FavoriteSuccess extends FavoriteState {
  final String message;

  const FavoriteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteHasData extends FavoriteState {
  final bool isAdded;

  const FavoriteHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}
