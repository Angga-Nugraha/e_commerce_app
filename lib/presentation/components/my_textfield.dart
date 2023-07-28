part of "components_helper.dart";

Widget myTextfield({
  required String label,
  TextEditingController? controller,
  String? Function(String?)? validator,
  TextInputType? type,
  Widget? suffixIcon,
  bool? obscureText = false,
}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator ??
        (value) => value!.isEmpty ? "$label tidak boleh kosong" : null,
    controller: controller,
    obscureText: obscureText!,
    keyboardType: type,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: kLabel.copyWith(fontSize: 12),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      suffixIcon: suffixIcon,
    ),
  );
}
