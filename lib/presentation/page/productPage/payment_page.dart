import 'package:e_commerce_app/data/common/const.dart';
import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/entities/user.dart';
import 'package:e_commerce_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({required this.cart, super.key});

  final Cart cart;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> payMethode = ["Cash/COD", "Transfer Bank"];
  static User? user;
  int? choosing;
  String nChoosing = "Cash/COD";

  double price = 0;

  void choseMethode(String value) {
    setState(() {
      nChoosing = value;
    });
  }

  void totalPrice(List<Product> products) {
    double total = 0;

    for (var product in products) {
      total += product.price! * product.quantity;
    }
    price = total;
  }

  @override
  void initState() {
    super.initState();
    totalPrice(widget.cart.products);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: "Payment",
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Info",
                    style: kLabel,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserHasData) {
                        user = state.result;
                      }
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 2.5,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name : ${user?.name.firstname} ${user?.name.lastname}',
                                    style: kSubTitle,
                                  ),
                                  Text(
                                    'No. Tlp : ${user?.phone}',
                                    style: kSubTitle,
                                  ),
                                  Text(
                                    'City : ${user?.address.city}',
                                    style: kSubTitle,
                                  ),
                                  Text(
                                    'Street : ${user?.address.street}',
                                    style: kSubTitle,
                                  ),
                                  Text(
                                    'Number : ${user?.address.number}',
                                    style: kSubTitle,
                                  ),
                                  Text(
                                    'Zipcode : ${user?.address.zipcode}',
                                    style: kSubTitle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              right: 10,
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.red[600],
                              ))
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Product Items",
                    style: kLabel,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.cart.products.length,
                      itemBuilder: (context, index) {
                        return myListTileProduct(context,
                            product: widget.cart.products[index],
                            quantity: true);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Promo Code",
                    style: kLabel,
                  ),
                  const SizedBox(height: 10),
                  myTextfield(
                    label: 'Type your code promo here',
                    suffixIcon: const Icon(Icons.discount_outlined),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Pay Method",
                    style: kLabel,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    value: nChoosing,
                    items: payMethode
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      choseMethode(value ?? '');
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
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
                          'Total Amount',
                          style: kLabel,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '\$ $price',
                          style: kTitle,
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<MyOrderBloc, MyOrderState>(
                    listener: (context, state) {
                      if (state is OrderSuccessState) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                height: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Icons.shopify_rounded,
                                        size: 50,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Successful!",
                                      style: kTitle,
                                    ),
                                    const SizedBox(height: 30),
                                    (() {
                                      switch (nChoosing) {
                                        case "Cash/COD":
                                          return Text(
                                              "Order successful, please make payment to courir after your product recived.",
                                              style: kSubTitle,
                                              textAlign: TextAlign.center);

                                        case "Transfer Bank":
                                          return Column(
                                            children: [
                                              Text(
                                                "Order is successful, please make payment after this process is complete to our Rekening Bank",
                                                style: kSubTitle,
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 30),
                                              Text(
                                                rekening,
                                                style: kLabel,
                                              ),
                                              GestureDetector(
                                                child: const Icon(
                                                  Icons.copy,
                                                  color: Colors.blue,
                                                ),
                                                onTap: () {
                                                  Clipboard.setData(
                                                      const ClipboardData(
                                                          text: rekening));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Copy to clipboard'),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        default:
                                          return Container();
                                      }
                                    }()),
                                    const SizedBox(height: 30),
                                    myBotton(
                                        onPressed: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              botNavBarRoute,
                                              arguments: userId,
                                              (route) => false);
                                        },
                                        label: "Back to Home",
                                        context: context)
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is MyOrderLoading) {
                        return myLoading(title: "Creating Order");
                      }
                      return myBotton(
                          onPressed: () {
                            context
                                .read<MyOrderBloc>()
                                .add(CreateOrder(cart: widget.cart));
                          },
                          label: 'Place Order',
                          context: context);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
