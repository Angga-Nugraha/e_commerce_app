part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchHasData extends SearchState {
  final List<Product> result;

  const SearchHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class SearchHasError extends SearchState {
  final String message;

  const SearchHasError({required this.message});

  @override
  List<Object> get props => [message];
}
