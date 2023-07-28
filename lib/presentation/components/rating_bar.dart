part of 'components_helper.dart';

Widget ratingBar({required String rate}) {
  return Container(
    width: 40,
    decoration: const BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: Colors.amber[800],
        ),
        Text(
          rate,
          style: kSubTitle.copyWith(color: Colors.white),
        ),
      ],
    ),
  );
}
