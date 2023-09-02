import "dart:math";

import "package:e_commerce_app/data/common/routes.dart";
import "package:e_commerce_app/data/common/style.dart";
import "package:e_commerce_app/domain/entities/product.dart";
import "package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart";
import "package:e_commerce_app/presentation/components/components_helper.dart";
import 'package:e_commerce_app/presentation/widgets/product_card.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final random = Random();

  Product? _recomendation;
  List<Product> topRated = [];
  List<Product> allProduct = [];
  Set _categories = {};

  Product setRecomendation(List<Product> listProduct) {
    _recomendation = listProduct[random.nextInt(listProduct.length)];

    return _recomendation!;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductHasError) {
            myDialog(
              context: context,
              content: 'No internet conection',
              onPressed1: () => Navigator.pop(context),
              onPressed2: () => Navigator.pop(context),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<ProductBloc>().add(FetchAllProduct()),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: kTitle,
                ),
                Text(
                  "To our Fashions App",
                  style: kLabel.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () =>
                            Navigator.pushNamed(context, searchPageRoutes),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[300]),
                          child: Center(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: kSubTitle,
                                prefixIcon: const Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Flexible(
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.dashboard_outlined,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return listTileShimmer();
                    }
                    if (state is ProductHasData) {
                      var product = setRecomendation(state.topRatedProduct);
                      return myListTileProduct(context, product: product);
                    }
                    return Container();
                  },
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 0.1,
                  height: 20,
                ),
                Text(
                  "Categories",
                  style: kTitle.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 10),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return listShimmer();
                    }
                    if (state is ProductHasData) {
                      _categories = state.allCategory.toSet();
                    }
                    return _listCategories(_categories);
                  },
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 0.1,
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    "Top Rated",
                    style: kTitle.copyWith(fontSize: 22),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, productPageRoute,
                          arguments: "Top Rated");
                    },
                    child: Text(
                      'View all',
                      style: kLabel,
                    ),
                  ),
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return gridViewShimmer();
                    }
                    if (state is ProductHasData) {
                      topRated = state.topRatedProduct;
                    }
                    return _buildListProduct(product: topRated);
                  },
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 0.1,
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    "All Product",
                    style: kTitle.copyWith(fontSize: 22),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, productPageRoute,
                          arguments: "All Product");
                    },
                    child: Text(
                      'View all',
                      style: kLabel,
                    ),
                  ),
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return gridViewShimmer();
                    }
                    if (state is ProductHasData) {
                      allProduct = state.listProduct;
                    }
                    return _buildListProduct(product: allProduct);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListProduct({required List<Product> product}) {
    return Container(
      padding: EdgeInsets.zero,
      height: 400,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: product.length,
        itemBuilder: (context, index) {
          return ProductCard(product: product[index]);
        },
      ),
    );
  }

  Widget _listCategories(Set categories) {
    return Container(
      padding: EdgeInsets.zero,
      height: 30,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, categoryPageRoute,
                  arguments: categories.elementAt(index));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    capitalize(categories.elementAt(index)),
                    style: kSubTitle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}
