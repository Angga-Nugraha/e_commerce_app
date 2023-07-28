import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/data/database/preference_helper.dart';
import 'package:e_commerce_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/components_helper.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String? firstName;
  String? lastName;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _drawerHeader(),
          _drawerItems(
              icon: Icons.favorite,
              text: "My Favorites",
              onTap: () {
                Navigator.pushNamed(context, favoritePageRoutes);
              }),
          _drawerItems(
            icon: Icons.category_sharp,
            text: "Categories",
            onTap: () => Navigator.pushNamed(context, allCategoryPageRoutes),
          ),
          _drawerItems(
            icon: Icons.language,
            text: "Language",
            onTap: () => myDialog(
              context: context,
              title: 'Upss Sorry',
              content: 'This fitur not ready to use',
              onPressed1: () => Navigator.pop(context),
              onPressed2: () => Navigator.pop(context),
            ),
          ),
          _drawerItems(
            icon: Icons.settings,
            text: "Settings",
            onTap: () => myDialog(
              context: context,
              title: 'Upss Sorry',
              content: 'This fitur not ready to use',
              onPressed1: () => Navigator.pop(context),
              onPressed2: () => Navigator.pop(context),
            ),
          ),
          _drawerItems(
            icon: Icons.logout,
            text: "Logout",
            onTap: () {
              myDialog(
                title: "Logout",
                content: "Yakin keluar?",
                context: context,
                onPressed1: () {
                  preferencesHelper.deleteToken();
                  preferencesHelper.deleteUserId();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    firstPageRoute,
                    (route) => false,
                  );
                },
                onPressed2: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          const Expanded(
            flex: 5,
            child: SizedBox(height: 200),
          ),
          Expanded(
            child: Text(
              "2023 \u00a9 Angga Nugraha \u{1f60e}",
              style: kSubTitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItems({
    IconData? icon,
    String? text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              text!,
              style: kLabel,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _drawerHeader() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserHasData) {
          firstName = capitalize(state.result.name.firstname);
          lastName = capitalize(state.result.name.lastname);
          email = capitalize(state.result.email);
        }
        return UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: Colors.black87),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            backgroundImage: const AssetImage('assets/img/avatar.png'),
            radius: 50,
          ),
          accountName: Text(
            '${firstName ?? 'User'} ${lastName ?? 'name'}',
            style: kLabel,
          ),
          accountEmail: Text(
            email ?? 'email',
            style: kSubTitle,
          ),
        );
      },
    );
  }
}
