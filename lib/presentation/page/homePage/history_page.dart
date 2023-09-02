import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/presentation/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({required this.id, super.key});
  final int id;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Product> allProduct = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<MyOrderBloc>(context, listen: false)
              .add(FetchAllOrderCart(userId: widget.id)),
          BlocProvider.of<ProductBloc>(context, listen: false)
              .add(FetchAllProduct()),
        ]);
  }

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
            const SizedBox(height: 10),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                    child: Wrap(
                      children: List.generate(
                        4,
                        (index) => listTileShimmer(),
                      ),
                    ),
                  );
                } else if (state is ProductHasData) {
                  allProduct = state.listProduct;
                  return BlocBuilder<MyOrderBloc, MyOrderState>(
                    builder: (context, state) {
                      if (state is MyOrderHasError) {
                        return Text(state.message);
                      } else if (state is MyOrderHasData) {
                        var listCart = state.result;

                        return Wrap(
                          children: List.generate(listCart.length, (index) {
                            return Column(
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
                                    Text(
                                      'Date : ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(listCart[index].date))}',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    children: List.generate(
                                        listCart[index].products.length, (i) {
                                      for (var product in allProduct) {
                                        if (product.id ==
                                            state
                                                .result[index].products[i].id) {
                                          product.quantity = listCart[index]
                                              .products[i]
                                              .quantity;
                                          listCart[index].products[i] = product;
                                        }
                                      }
                                      return myListTileProduct(
                                        context,
                                        product: listCart[index].products[i],
                                        quantity: true,
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
