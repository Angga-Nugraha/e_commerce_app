import 'package:e_commerce_app/presentation/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

import 'introduction_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({required this.token, required this.id, super.key});

  final String token;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/splash.png"),
                  fit: BoxFit.fill,
                ),
              ),
            );
          } else {
            if (token.isEmpty) {
              return const IntroductionPage();
            } else {
              return NavigationBarPage(id: id);
            }
          }
        },
      ),
    );
  }
}
