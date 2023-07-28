import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoryPage extends StatefulWidget {
  const AllCategoryPage({super.key});

  @override
  State<AllCategoryPage> createState() => _AllCategoryPageState();
}

class _AllCategoryPageState extends State<AllCategoryPage> {
  Set<String> _categories = {};

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, title: "All Category"),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductHasData) {
            _categories = state.allCategory.toSet();
          }
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, categoryPageRoute,
                          arguments: _categories.elementAt(index));
                    },
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          capitalize(_categories.elementAt(index)),
                          style: kTitle.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
