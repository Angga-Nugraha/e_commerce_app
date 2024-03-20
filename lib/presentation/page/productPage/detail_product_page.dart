import 'package:e_commerce_app/presentation/components/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/detail_product_bloc/detail_product_bloc.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  double? price;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<DetailProductBloc>(context, listen: false)
            ..add(FetchSingleProduct(id: widget.id)),
          BlocProvider.of<FavoriteBloc>(context, listen: false)
            ..add(CheckFavoriteStatus(id: widget.id)),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartAddedState) {
              mySnackBar(context, content: state.message);
            }
            if (state is CartHasError) {}
          },
          child: Stack(
            children: [
              BlocBuilder<DetailProductBloc, DetailProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductHasData) {
                    price = state.product.price;
                    return _buildContent(
                        product: state.product, context: context);
                  }
                  if (state is ProductHasError) {
                    return Center(
                      child: Text(
                        'No internet connection',
                        style: kSubTitle,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: myIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent({
    required Product product,
    required BuildContext context,
  }) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: CachedNetworkImage(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            imageUrl: product.image!,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        DraggableScrollableSheet(
          maxChildSize: 0.8,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: double.infinity,
                    margin: const EdgeInsets.only(top: 20, bottom: 60),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title!,
                            style: kTitle.copyWith(fontSize: 24),
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.1,
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  product.category!.toUpperCase(),
                                  style: kSubTitle,
                                ),
                              ),
                              RatingBarIndicator(
                                rating: product.rating!.rate,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.amber[700],
                                  );
                                },
                                itemSize: 18,
                              ),
                              Text(
                                '${product.rating!.rate}',
                                style: kSubTitle,
                              )
                            ],
                          ),
                          Text(
                            "Available Stock : ${product.rating!.count} Pcs",
                            style: kSubTitle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Description",
                            style: kLabel,
                          ),
                          Text(
                            ('${product.description} ') * 2,
                            style: kSubTitle,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    color: Colors.black,
                    height: 4,
                    width: 48,
                  ),
                ],
              ),
            );
          },
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteHasData) {
              isFavorite = state.isAdded;
            }
            return Positioned(
              right: 20,
              top: 20,
              child: myIconButton(
                onPressed: () async {
                  if (isFavorite == false) {
                    context
                        .read<FavoriteBloc>()
                        .add(AddToFavorite(product: product));
                  } else {
                    context.read<FavoriteBloc>()
                      ..add(DeleteFromFavorite(product: product))
                      ..add(FetchAllFavorite());
                  }
                },
                icon: !isFavorite ? Icons.favorite_border : Icons.favorite,
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Card(
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'Price',
                          style: kLabel,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '\$$price',
                          style: kTitle,
                        ),
                      ),
                    ],
                  ),
                  myBotton(
                      context: context,
                      label: "Add to cart",
                      onPressed: () {
                        context.read<CartBloc>()
                          ..add(AddItemToCart(product: product))
                          ..add(GettingAllcart());
                      }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
