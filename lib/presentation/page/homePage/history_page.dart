import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Cart> listCart = [];
  List<Product> listProduct = [];
  List<Product> allProduct = [];
  List<Product> productCart = [];
  String date = '';

  void getProductCart(List<Product> product) {
    for (var element in allProduct) {
      for (var value in product) {
        if (element.id == value.id) {
          productCart.add(element);
        }
      }
    }
    for (var i = 0; i < productCart.length; i++) {
      for (var value in product) {
        if (productCart.elementAt(i).id == value.id) {
          productCart.elementAt(i).quantity = value.quantity;
        }
      }
    }
  }

  @override
  void initState() {
    Future.microtask(() => [
          BlocProvider.of<ProductBloc>(context, listen: false)
              .add(FetchAllProduct()),
          BlocProvider.of<MyOrderBloc>(context, listen: false)
              .add(FetchAllOrderCart(userId: userId)),
        ]);
    super.initState();
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
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductHasData) {
                  allProduct = state.listProduct;
                }
                return BlocBuilder<MyOrderBloc, MyOrderState>(
                  builder: (context, state) {
                    if (state is MyOrderLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is MyOrderHasError) {
                      return Text(state.message);
                    }
                    if (state is MyOrderHasData) {
                      listCart = state.result;
                      listProduct = listCart.map((e) => e.products).first;
                      getProductCart(listProduct);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCart.length,
                        itemBuilder: (context, index) {
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
                                    itemCount: listCart[index].products.length,
                                    itemBuilder: (context, index) {
                                      return myListTileProduct(context,
                                          product: productCart.elementAt(index),
                                          quantity: true);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
