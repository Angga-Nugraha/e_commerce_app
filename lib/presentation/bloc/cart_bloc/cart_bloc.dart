import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_cart.dart';
import 'package:e_commerce_app/domain/usecase/product/insert_to_cart.dart';
import 'package:e_commerce_app/domain/usecase/product/remove_from_cart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  GetAllCart getAllCart;
  InsertToCart insertToCart;
  RemoveFromCart removeFromCart;

  CartBloc(
      {required this.getAllCart,
      required this.insertToCart,
      required this.removeFromCart})
      : super(CartInitial()) {
    on<GettingAllcart>((event, emit) async {
      emit(CartLoading());

      final result = await getAllCart.execute();

      result.fold(
        (failure) => emit(CartHasError(message: failure.message)),
        (data) => emit(CartHasdata(result: data)),
      );
    });
    on<AddItemToCart>((event, emit) async {
      final product = event.product;

      final result = await insertToCart.execute(product);
      result.fold(
        (failure) => emit(CartHasError(message: failure.message)),
        (data) => emit(CartAddedState(message: data)),
      );
    });

    on<RemoveItemToCart>((event, emit) async {
      final product = event.product;

      final result = await removeFromCart.execute(product);
      result.fold(
        (failure) => emit(CartHasError(message: failure.message)),
        (data) => emit(CartRemoveState(message: data)),
      );
    });
  }
}
