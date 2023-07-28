part of 'components_helper.dart';

void myDialog({
  required BuildContext context,
  VoidCallback? onPressed1,
  VoidCallback? onPressed2,
  String? title,
  String? content,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title ?? "Something wrong",
        style: kLabel,
      ),
      content: Text(
        content ?? "",
        style: kSubTitle,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed1,
          child: Text('OK', style: kSubTitle),
        ),
        TextButton(
          onPressed: onPressed2,
          child: Text('Cancel', style: kSubTitle),
        ),
      ],
    ),
  );
}
