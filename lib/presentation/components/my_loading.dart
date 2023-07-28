part of "components_helper.dart";

Widget myLoading({String? title}) {
  return Center(
    child: SizedBox(
      height: 60,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircularProgressIndicator(
            color: Colors.black,
          ),
          Expanded(
            child: Text(
              title!,
              style: kSubTitle,
            ),
          )
        ],
      ),
    ),
  );
}
