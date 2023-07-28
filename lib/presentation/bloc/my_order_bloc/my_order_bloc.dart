import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/usecase/product/create_new_order.dart';
import 'package:e_commerce_app/domain/usecase/product/get_my_order_cart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_order_event.dart';
part 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  GetMyOrderCart getMyOrderCart;
  CreateNewOrder createNewOrder;

  MyOrderBloc({required this.getMyOrderCart, required this.createNewOrder})
      : super(MyOrderInitial()) {
    on<FetchAllOrderCart>((event, emit) async {
      emit(MyOrderLoading());

      final result = await getMyOrderCart.execute(event.userId);

      Future.delayed(const Duration(seconds: 10));
      result.fold(
        (failure) => emit(MyOrderHasError(message: failure.message)),
        (data) => emit(MyOrderHasData(result: data)),
      );
    });

    on<CreateOrder>((event, emit) async {
      emit(MyOrderLoading());
      final result = await createNewOrder.execute(event.cart);
      result.fold(
        (failure) => emit(MyOrderHasError(message: failure.message)),
        (data) => emit(OrderSuccessState(result: data)),
      );
    });
  }
}
