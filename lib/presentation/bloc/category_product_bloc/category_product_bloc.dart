import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_product_categories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final GetProductCategory getProductCategory;

  CategoryProductBloc({required this.getProductCategory})
      : super(CategoryProductInitial()) {
    on<FetchCategoryProduct>(
      (event, emit) async {
        emit(CategoryLoading());
        final result = await getProductCategory.execute(event.query);
        result.fold(
          (failure) => emit(CategoryHasError(message: failure.message)),
          (data) => emit(CategoryHasData(result: data)),
        );
      },
    );
  }
}
