import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/usecase/product/search_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProduct searchProduct;

  SearchBloc({required this.searchProduct}) : super(SearchInitial()) {
    on<OnQueryChanged>((event, emit) async {
      emit(SearchLoading());

      final result = await searchProduct.execute(event.query);
      result.fold(
        (failure) => emit(SearchHasError(message: failure.message)),
        (data) => emit(SearchHasData(result: data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 300)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
