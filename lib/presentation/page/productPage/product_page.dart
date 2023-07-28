import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({required this.title, super.key});

  final String title;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<ProductBloc>(context, listen: false)
        .add(FetchAllProduct()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: widget.title,
        trailingIcon: Icons.search,
        trailingOnTap: () {
          Navigator.pushNamed(context, searchPageRoutes);
        },
      ),
      body: (() {
        switch (widget.title) {
          case 'Top Rated':
            return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: gridViewShimmer(isVertical: true),
                  );
                }
                if (state is ProductHasData) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.topRatedProduct.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: state.topRatedProduct[index]);
                    },
                  );
                }
                return Container();
              },
            );
          case 'All Product':
            return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: gridViewShimmer(isVertical: true),
                  );
                }
                if (state is ProductHasData) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.listProduct.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: state.listProduct[index]);
                    },
                  );
                }
                return Container();
              },
            );
          default:
            return Container();
        }
      }()),
    );
  }
}
