import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/presentation/bloc/category_product_bloc/category_product_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/widgets/list_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductPage extends StatefulWidget {
  const CategoryProductPage({required this.title, super.key});

  final String title;

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<CategoryProductBloc>(context, listen: false)
          ..add(FetchCategoryProduct(query: widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: capitalize(widget.title),
        trailingIcon: Icons.search,
        trailingOnTap: () {
          Navigator.pushNamed(context, searchPageRoutes);
        },
      ),
      body: BlocBuilder<CategoryProductBloc, CategoryProductState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return listTileShimmer();
              },
              itemCount: 10,
            );
          }

          if (state is CategoryHasData) {
            return ListProduct(listProduct: state.result);
          }
          return Container();
        },
      ),
    );
  }
}
