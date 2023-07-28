import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({
    super.key,
    required this.listProduct,
  });

  final List<Product> listProduct;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, detailProductRoute,
                    arguments: listProduct[index].id);
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Card(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 130,
                        bottom: 10,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listProduct[index].title!,
                            maxLines: 2,
                            style: kLabel,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            listProduct[index].description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '\$${listProduct[index].price}',
                                  style: kLabel,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.amber[800],
                              ),
                              Text(listProduct[index].rating!.rate.toString(),
                                  style: kSubTitle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
                        width: 100,
                        imageUrl: listProduct[index].image!,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
