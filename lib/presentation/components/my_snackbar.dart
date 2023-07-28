import 'package:flutter/material.dart';

void mySnackBar(BuildContext context, {required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(content)),
    duration: const Duration(seconds: 2),
    width: 120,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}
