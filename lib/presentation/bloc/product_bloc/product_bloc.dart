import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_category.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_top_rated_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProduct getAllProduct;
  final GetTopRatedProduct getTopRatedProduct;
  final GetAllCategory getAllCategory;

  ProductBloc({
    required this.getAllProduct,
    required this.getAllCategory,
    required this.getTopRatedProduct,
  }) : super(ProductInitial()) {
    on<FetchAllProduct>((event, emit) async {
      emit(ProductLoading());

      final productList = await getAllProduct.execute();
      final topRated = await getTopRatedProduct.execute();
      final allCategory = await getAllCategory.execute();

      productList.fold(
        (failure) => emit(ProductHasError(message: failure.message)),
        (listProduct) {
          topRated.fold(
              (failure) => emit(ProductHasError(message: failure.message)),
              (topProduct) {
            allCategory.fold(
              (failure) => emit(ProductHasError(message: failure.message)),
              (category) => emit(
                ProductHasData(
                  listProduct: listProduct,
                  topRatedProduct: topProduct,
                  allCategory: category,
                ),
              ),
            );
          });
        },
      );
    });
  }
}
