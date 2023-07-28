import 'package:e_commerce_app/data/datasource/authentication.dart';
import 'package:e_commerce_app/data/datasource/location.dart';
import 'package:e_commerce_app/data/datasource/product_local_datasource.dart';
import 'package:e_commerce_app/data/datasource/product_remote_datasource.dart';
import 'package:e_commerce_app/data/repository/auth_repository_impl.dart';
import 'package:e_commerce_app/data/repository/location_repository_impl.dart';
import 'package:e_commerce_app/data/repository/product_repository_impl.dart';
import 'package:e_commerce_app/domain/repository/auth_repository.dart';
import 'package:e_commerce_app/domain/repository/location_repository.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';
import 'package:e_commerce_app/domain/usecase/auth/authenticated.dart';
import 'package:e_commerce_app/domain/usecase/auth/edit_user.dart';
import 'package:e_commerce_app/domain/usecase/product/create_new_order.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_cart.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_category.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_favorite.dart';
import 'package:e_commerce_app/domain/usecase/product/get_all_product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_my_order_cart.dart';
import 'package:e_commerce_app/domain/usecase/product/get_product_status.dart';
import 'package:e_commerce_app/domain/usecase/product/insert_to_cart.dart';
import 'package:e_commerce_app/domain/usecase/product/insert_to_favorite.dart';
import 'package:e_commerce_app/domain/usecase/product/remove_from_cart.dart';
import 'package:e_commerce_app/domain/usecase/product/remove_from_favorite.dart';
import 'package:e_commerce_app/domain/usecase/user/get_location.dart';
import 'package:e_commerce_app/domain/usecase/product/get_product_categories.dart';
import 'package:e_commerce_app/domain/usecase/product/get_single_product.dart';
import 'package:e_commerce_app/domain/usecase/product/get_top_rated_product.dart';
import 'package:e_commerce_app/domain/usecase/user/get_user_by_id.dart';
import 'package:e_commerce_app/domain/usecase/product/search_product.dart';
import 'package:e_commerce_app/domain/usecase/auth/sign_up.dart';
import 'package:e_commerce_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/category_product_bloc/category_product_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/detail_product_bloc/detail_product_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/search_product_bloc/search_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/presentation/widgets/permission.dart'
    as permission;

final locator = GetIt.instance;

void init() {
  // BLOC
  locator.registerFactory(
      () => UserBloc(getUserById: locator(), editUser: locator()));

  locator.registerFactory(() => SearchBloc(searchProduct: locator()));

  locator.registerFactory(() => LocationBloc(getLocation: locator()));

  locator.registerFactory(() => DetailProductBloc(getSingleProduct: locator()));

  locator.registerFactory(
      () => CategoryProductBloc(getProductCategory: locator()));

  locator.registerFactory(() => AuthBloc(
        authenticated: locator(),
        signUp: locator(),
      ));

  locator.registerFactory(() => ProductBloc(
        getAllProduct: locator(),
        getTopRatedProduct: locator(),
        getAllCategory: locator(),
      ));

  locator.registerFactory(
      () => MyOrderBloc(getMyOrderCart: locator(), createNewOrder: locator()));

  locator.registerFactory(() => CartBloc(
      getAllCart: locator(),
      insertToCart: locator(),
      removeFromCart: locator()));

  locator.registerFactory(() => FavoriteBloc(
      getAllFavorite: locator(),
      getProductStatus: locator(),
      insertToFavorite: locator(),
      removeFromFavorite: locator()));

  // USECASE
  locator.registerLazySingleton(
      () => Authenticated(authenticationRepository: locator()));

  locator.registerLazySingleton(
      () => GetUserById(authenticationRepository: locator()));

  locator
      .registerLazySingleton(() => SignUp(authenticationRepository: locator()));

  locator.registerLazySingleton(
      () => EditUser(authenticationRepository: locator()));

  locator
      .registerLazySingleton(() => GetAllProduct(productRepository: locator()));

  locator
      .registerLazySingleton(() => SearchProduct(productRepository: locator()));

  locator.registerLazySingleton(
      () => GetTopRatedProduct(productRepository: locator()));

  locator.registerLazySingleton(
      () => GetAllCategory(productRepository: locator()));

  locator.registerLazySingleton(
      () => GetSingleProduct(productRepository: locator()));

  locator.registerLazySingleton(
      () => GetProductCategory(productRepository: locator()));

  locator.registerLazySingleton(() => GetAllCart(productRepository: locator()));

  locator.registerLazySingleton(
      () => GetMyOrderCart(productRepository: locator()));

  locator.registerLazySingleton(
      () => CreateNewOrder(productRepository: locator()));

  locator
      .registerLazySingleton(() => InsertToCart(productRepository: locator()));

  locator.registerLazySingleton(
      () => RemoveFromCart(productRepository: locator()));
  locator.registerLazySingleton(
      () => GetAllFavorite(productRepository: locator()));

  locator.registerLazySingleton(
      () => InsertToFavorite(productRepository: locator()));

  locator.registerLazySingleton(
      () => RemoveFromFavorite(productRepository: locator()));

  locator.registerLazySingleton(
      () => GetProductStatus(productRepository: locator()));

  locator
      .registerLazySingleton(() => GetLocation(locationRepository: locator()));

  // REPOSITORY
  locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthRepositoryImpl(authentication: locator()));

  locator.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(getLocationUser: locator()));

  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      productRemoteDatasource: locator(), productLocalDatasource: locator()));

  // DATASOURCE
  locator.registerLazySingleton<Authentication>(
      () => AuthenticationImpl(locator()));
  locator.registerLazySingleton<GetLocationUser>(() => GetLocationUserImpl());

  locator.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDatasourceImpl(locator()));

  locator.registerLazySingleton<ProductLocalDatasource>(
      () => ProductLocalDatasourceImpl());

  // EXTERNAL HTTP
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => permission.PermissionHelper());
}
