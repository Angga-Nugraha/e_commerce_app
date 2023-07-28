import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, detailProductRoute, arguments: product.id);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    height: 100,
                    fit: BoxFit.contain,
                    width: 200,
                    imageUrl: product.image!,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                ratingBar(rate: product.rating!.rate.toString())
              ],
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                product.title!,
                textAlign: TextAlign.center,
                style: kLabel.copyWith(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
              subtitle: Text(
                "\$ ${product.price.toString()}",
                textAlign: TextAlign.center,
                style: kLabel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// 