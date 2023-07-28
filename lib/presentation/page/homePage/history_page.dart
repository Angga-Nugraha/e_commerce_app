import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    // final id = userId;
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<MyOrderBloc>(context, listen: false)
              .add(FetchAllOrderCart(userId: userId)),
          BlocProvider.of<ProductBloc>(context, listen: false)
              .add(FetchAllProduct()),
        ]);
  }

  List<Cart> listCart = [];
  List<Product> listProduct = [];
  List<Product> allProduct = [];
  List<Product> product = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Order',
              style: kTitle,
            ),
            BlocBuilder<MyOrderBloc, MyOrderState>(
              builder: (context, state) {
                if (state is MyOrderLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is MyOrderHasData) {
                  listCart = state.result;
                  return BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductHasData) {
                        allProduct = state.listProduct;
                        for (var i = 0; i < listProduct.length; i++) {
                          product.add(allProduct
                              .map((e) => e)
                              .where(
                                  (element) => element.id == listProduct[i].id)
                              .first);
                        }
                        for (var i = 0; i < product.length; i++) {
                          if (product[i].id == listProduct[i].id) {
                            product[i].quantity = listProduct[i].quantity;
                          }
                        }
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: listCart.length,
                          itemBuilder: (context, index) {
                            final date = DateFormat("yyyy-MM-dd")
                                .format(DateTime.parse(listCart[index].date));
                            listProduct = listCart[index].products;

                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        color: Colors.lightGreen,
                                        child: const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Completed'),
                                        ),
                                      ),
                                      Text(date),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: product.length,
                                      itemBuilder: (context, index) {
                                        return myListTileProduct(context,
                                            product: product[index],
                                            quantity: true);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
