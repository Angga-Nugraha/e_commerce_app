import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/presentation/bloc/search_product_bloc/search_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/widgets/list_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  myIconButton(
                      icon: Icons.arrow_back,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[300]),
                      child: Center(
                        child: TextField(
                          onChanged: (query) {
                            context
                                .read<SearchBloc>()
                                .add(OnQueryChanged(query: query));
                          },
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
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SearchHasData) {
                    return state.result.isNotEmpty
                        ? Expanded(
                            child: ListProduct(listProduct: state.result))
                        : Center(
                            child: Text(
                              "Product not found",
                              style: kSubTitle,
                            ),
                          );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
