part of 'components_helper.dart';

AppBar myAppBar(BuildContext context,
    {GestureTapCallback? leadingOnTap,
    GestureTapCallback? trailingOnTap,
    IconData? leadingIcon,
    String? title,
    IconData? trailingIcon}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      leading: myIconButton(
        icon: leadingIcon ?? Icons.arrow_back,
        onPressed: leadingOnTap ?? () => Navigator.pop(context),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      title: Text(
        title ?? '',
        style: kTitle,
      ),
      trailing: myIconButton(
        icon: trailingIcon,
        onPressed: trailingOnTap,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    ),
  );
}
