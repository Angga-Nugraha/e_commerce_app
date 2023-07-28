import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double price = 0;
  int totalItems = 0;
  List<Product> listProduct = [];

  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<CartBloc>(context, listen: false)
      ..add(GettingAllcart()));
  }

  void totalPrice(List<Product> products) {
    double total = 0;
    int item = 0;

    for (var product in products) {
      total += product.price! * product.quantity;
      item += product.quantity;
    }
    price = total;
    totalItems = item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: "My Cart",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartHasdata) {
              listProduct = state.result;
              totalPrice(listProduct);
            }
            return Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: listProduct.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.create_new_folder_sharp,
                              color: Colors.grey,
                            ),
                            Text(
                              "Your cart is empty, try selecting some items in the shop",
                              style: kSubTitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : _buildListCart(product: listProduct),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Item : ', style: kLabel),
                            Text('$totalItems pcs', style: kLabel),
                          ],
                        ),
                        const Divider(thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal : ', style: kLabel),
                            Text('\$ $price', style: kLabel),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                myBotton(
                    context: context,
                    label: "Procced to checkout",
                    onPressed: () {
                      final finalProduct = Cart(
                        id: 1,
                        userId: userId,
                        date: date,
                        products: listProduct,
                      );
                      if (finalProduct.products
                              .map((e) => e.quantity)
                              .contains(0) ||
                          listProduct.isEmpty) {
                        myDialog(
                            context: context,
                            content:
                                "Pastikan anda memilih jumlah product yang akan di beli",
                            onPressed1: () => Navigator.pop(context),
                            onPressed2: () => Navigator.pop(context));
                      } else {
                        Navigator.pushNamed(context, paymentPageRoutes,
                            arguments: finalProduct);
                      }
                    }),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  ListView _buildListCart({required List<Product> product}) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: product.length,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 220),
                Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
              ],
            ),
          ),
          key: Key(product[index].id.toString()),
          onDismissed: (direction) {
            context.read<CartBloc>()
              ..add(RemoveItemToCart(product: product[index]))
              ..add(GettingAllcart());
            product.removeAt(index);
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              myListTileProduct(context, product: product[index]),
              Container(
                margin: const EdgeInsets.all(10),
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (product[index].quantity > 0) {
                            setState(() {
                              product[index].quantity--;
                            });
                            context.read<CartBloc>()
                              ..add(AddItemToCart(product: product[index]))
                              ..add(GettingAllcart());

                            totalPrice(product);
                          }
                        },
                        child: const Icon(
                          Icons.remove,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      product[index].quantity.toString(),
                      style: kSubTitle,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            product[index].quantity++;
                          });
                          context.read<CartBloc>()
                            ..add(AddItemToCart(product: product[index]))
                            ..add(GettingAllcart());
                          totalPrice(product);
                        },
                        child: const Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
