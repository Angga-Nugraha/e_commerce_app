import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/data/common/utils.dart';
import 'package:e_commerce_app/data/database/preference_helper.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/category_product_bloc/category_product_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/detail_product_bloc/detail_product_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/search_product_bloc/search_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:e_commerce_app/presentation/page/authPage/user_info.dart';
import 'package:e_commerce_app/presentation/page/productPage/all_category_page.dart';
import 'package:e_commerce_app/presentation/page/productPage/cart_page.dart';
import 'package:e_commerce_app/presentation/page/productPage/category_product_page.dart';
import 'package:e_commerce_app/presentation/page/productPage/detail_product_page.dart';
import 'package:e_commerce_app/presentation/page/main_page.dart';
import 'package:e_commerce_app/presentation/page/homePage/home_screen_page.dart';
import 'package:e_commerce_app/presentation/page/productPage/favorite_product_page.dart';
import 'package:e_commerce_app/presentation/page/productPage/payment_page.dart';
import 'package:e_commerce_app/presentation/page/productPage/product_page.dart';
import 'package:e_commerce_app/presentation/page/authPage/sign_up_page.dart';
import 'package:e_commerce_app/presentation/page/productPage/search_page.dart';
import 'package:e_commerce_app/presentation/widgets/bottom_navbar.dart';
import 'package:e_commerce_app/presentation/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'presentation/page/authPage/login_page.dart';
import 'injection.dart' as di;

String? token;
int? _userId;

int get userId => _userId ?? 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  token = await preferencesHelper.getToken();
  _userId = await preferencesHelper.getUserId();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<AuthBloc>()),
        BlocProvider(create: (_) => di.locator<UserBloc>()),
        BlocProvider(create: (_) => di.locator<CartBloc>()),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(
            create: (_) => di.locator<ProductBloc>()..add(FetchAllProduct())),
        BlocProvider(create: (_) => di.locator<LocationBloc>()),
        BlocProvider(create: (_) => di.locator<FavoriteBloc>()),
        BlocProvider(create: (_) => di.locator<MyOrderBloc>()),
        BlocProvider(create: (_) => di.locator<DetailProductBloc>()),
        BlocProvider(create: (_) => di.locator<CategoryProductBloc>()),
      ],
      child: MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        title: "E-Commerce Apps",
        navigatorObservers: [routeObserver],
        initialRoute: splashScreenRoute,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case splashScreenRoute:
              return MaterialPageRoute(
                builder: (_) => SplashScreen(token: token ?? '', id: userId),
              );
            case firstPageRoute:
              return MaterialPageRoute(builder: (_) => const MainPage());
            case userInfoRoutes:
              return MaterialPageRoute(builder: (_) => const UserInfo());
            case loginPageRoute:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case cartPageRoutes:
              return MaterialPageRoute(builder: (_) => const CartPage());
            case paymentPageRoutes:
              final cart = settings.arguments as Cart;
              return MaterialPageRoute(
                builder: (_) => PaymentPage(cart: cart),
              );
            case favoritePageRoutes:
              return MaterialPageRoute(
                  builder: (_) => const FavoriteProductPage());
            case signUpPageRoute:
              return MaterialPageRoute(builder: (_) => const SignUpPage());
            case botNavBarRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => NavigationBarPage(id: id));
            case homePageRoute:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case allCategoryPageRoutes:
              return MaterialPageRoute(builder: (_) => const AllCategoryPage());
            case searchPageRoutes:
              return MaterialPageRoute(builder: (_) => const SearchPage());
            case productPageRoute:
              final title = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => ProductPage(title: title),
              );
            case categoryPageRoute:
              final title = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => CategoryProductPage(title: title),
              );
            case detailProductRoute:
              int id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailProductPage(id: id));

            default:
              return null;
          }
        },
      ),
    );
  }
}
