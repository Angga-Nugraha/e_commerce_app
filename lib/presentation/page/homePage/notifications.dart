import 'package:e_commerce_app/data/common/style.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_none,
            color: Colors.grey,
          ),
          Text(
            "No Notifications",
            style: kSubTitle,
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
