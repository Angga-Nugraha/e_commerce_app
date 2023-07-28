part of 'components_helper.dart';

Widget myBotton({
  required VoidCallback onPressed,
  required String label,
  required BuildContext context,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    ),
    child: Text(
      label,
      style: kLabel,
    ),
  );
}
