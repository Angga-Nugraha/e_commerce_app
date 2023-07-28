import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_single_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final GetSingleProduct getSingleProduct;

  DetailProductBloc({required this.getSingleProduct})
      : super(DetailProductInitial()) {
    on<FetchSingleProduct>(
      (event, emit) async {
        emit(ProductLoading());
        final result = await getSingleProduct.execute(event.id);

        result.fold(
          (failure) => emit(ProductHasError(message: failure.message)),
          (data) => emit(ProductHasData(product: data)),
        );
      },
    );
  }
}
