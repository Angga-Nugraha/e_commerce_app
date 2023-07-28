import 'package:flutter/material.dart';
import 'package:e_commerce_app/data/common/routes.dart';
import '../components/components_helper.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/login_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            child: SizedBox(
              height: height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myBotton(
                    context: context,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, loginPageRoute);
                    },
                    label: "Login",
                  ),
                  const Text(
                    "or",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  myBotton(
                    context: context,
                    onPressed: () {
                      Navigator.pushNamed(context, signUpPageRoute);
                    },
                    label: "Sign Up",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
