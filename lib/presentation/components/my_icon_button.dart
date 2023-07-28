part of 'components_helper.dart';

Widget myIconButton({
  required IconData? icon,
  required GestureTapCallback? onPressed,
  Color? backgroundColor,
  Color? foregroundColor,
  double? size,
}) {
  return CircleAvatar(
    backgroundColor: backgroundColor ?? Colors.black,
    foregroundColor: foregroundColor ?? Colors.white,
    child: IconButton(
      splashRadius: 25,
      icon: Icon(
        icon,
        size: size,
      ),
      onPressed: onPressed,
    ),
  );
}
