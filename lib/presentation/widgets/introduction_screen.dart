import 'package:e_commerce_app/data/common/style.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../page/main_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final _key = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }

  Widget _buildImage(String imageName) {
    return ClipPath(
        clipper: DiagonalPathClipperTwo(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage("assets/img/$imageName"),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: kTitle,
      bodyAlignment: Alignment.center,
      bodyTextStyle: kSubTitle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: const EdgeInsets.all(20),
      imageFlex: 4,
      titlePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: _key,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 5000,
      pages: [
        PageViewModel(
          title: "20% Discount\nNew Arrival Product",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('img-1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Take Adventage\nOf The Offer Shopping",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('img-2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "All Types Offers\nWithin Your Reach",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('img-3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      showNextButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black87,
      ),
      done: const Text('Next',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
