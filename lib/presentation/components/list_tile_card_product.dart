part of 'components_helper.dart';

Widget myListTileProduct(BuildContext context,
    {required Product product, bool quantity = false}) {
  return InkWell(
    onTap: () =>
        Navigator.pushNamed(context, detailProductRoute, arguments: product.id),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: product.image!,
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    style: kLabel,
                  ),
                  Text(
                    product.category!,
                    style: kSubTitle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${product.price!}',
                        style: kLabel,
                      ),
                      quantity
                          ? Text(
                              'Quantity: ${product.quantity}',
                              style: kSubTitle,
                            )
                          : const Text(''),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
