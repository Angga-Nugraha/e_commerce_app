import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/widgets/list_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteProductPage extends StatefulWidget {
  const FavoriteProductPage({super.key});

  @override
  State<FavoriteProductPage> createState() => _FavoriteProductPageState();
}

class _FavoriteProductPageState extends State<FavoriteProductPage> {
  List<Product> favoriteProduct = [];
  @override
  void initState() {
    Future.microtask(() => BlocProvider.of<FavoriteBloc>(context, listen: false)
        .add(FetchAllFavorite()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: 'My Favorites',
        trailingIcon: Icons.search,
        trailingOnTap: () {
          Navigator.pushNamed(context, searchPageRoutes);
        },
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return listTileShimmer();
              },
              itemCount: 10,
            );
          }
          if (state is ListFavoriteProduct) {
            favoriteProduct = state.result;
          }
          return favoriteProduct.isNotEmpty
              ? ListProduct(listProduct: favoriteProduct)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.create_new_folder_sharp,
                        color: Colors.grey,
                      ),
                      Text(
                        "Don't have favorite items",
                        style: kSubTitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
