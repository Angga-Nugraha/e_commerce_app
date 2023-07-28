import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_favorite.dart';
import 'package:e_commerce_app/domain/usecase/product/get_product_status.dart';
import 'package:e_commerce_app/domain/usecase/product/insert_to_favorite.dart';
import 'package:e_commerce_app/domain/usecase/product/remove_from_favorite.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  GetProductStatus getProductStatus;
  InsertToFavorite insertToFavorite;
  RemoveFromFavorite removeFromFavorite;
  GetAllFavorite getAllFavorite;

  FavoriteBloc(
      {required this.getProductStatus,
      required this.insertToFavorite,
      required this.removeFromFavorite,
      required this.getAllFavorite})
      : super(FavoriteInitial(false)) {
    on<CheckFavoriteStatus>((event, emit) async {
      final result = await getProductStatus.execute(event.id);
      emit(FavoriteHasData(result));
    });

    on<AddToFavorite>((event, emit) async {
      final result = await insertToFavorite.execute(event.product);
      result.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (data) => emit(FavoriteSuccess(data)),
      );
      add(CheckFavoriteStatus(id: event.product.id));
    });
    on<DeleteFromFavorite>((event, emit) async {
      final result = await removeFromFavorite.execute(event.product);
      result.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (data) => emit(FavoriteSuccess(data)),
      );
      add(CheckFavoriteStatus(id: event.product.id));
    });

    on<FetchAllFavorite>((event, emit) async {
      emit(FavoriteLoading());

      final result = await getAllFavorite.execute();
      result.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (data) => emit(ListFavoriteProduct(result: data)),
      );
    });
  }
}
