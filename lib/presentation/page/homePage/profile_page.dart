import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/data/database/preference_helper.dart';
import 'package:e_commerce_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return listShimmer();
                }
                if (state is UserHasData) {
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Card(
                          color: Colors.grey.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              "assets/img/avatar.png",
                              width: 60,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${capitalize(state.result.name.firstname)} ${capitalize(state.result.name.lastname)}',
                              style: kTitle.copyWith(fontSize: 20),
                            ),
                            Text(
                              capitalize(state.result.email),
                              style: kSubTitle.copyWith(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 40),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                    style: BorderStyle.solid, color: Colors.grey.shade300),
              ),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    _buildProfileMenuTile(
                        onTap: () =>
                            Navigator.pushNamed(context, userInfoRoutes),
                        title: "Personal Details",
                        icon: Icons.person),
                    _buildProfileMenuTile(
                      title: "My Favorites",
                      icon: Icons.favorite,
                      onTap: () =>
                          Navigator.pushNamed(context, favoritePageRoutes),
                    ),
                    _buildProfileMenuTile(
                      title: "Shipping Address",
                      icon: Icons.location_city_rounded,
                      onTap: () => myDialog(
                        context: context,
                        title: 'Upss Sorry',
                        content: 'This fitur not ready to use',
                        onPressed1: () => Navigator.pop(context),
                        onPressed2: () => Navigator.pop(context),
                      ),
                    ),
                    _buildProfileMenuTile(
                      title: "My Card",
                      icon: Icons.wallet,
                      onTap: () => myDialog(
                        context: context,
                        title: 'Upss Sorry',
                        content: 'This fitur not ready to use',
                        onPressed1: () => Navigator.pop(context),
                        onPressed2: () => Navigator.pop(context),
                      ),
                    ),
                    _buildProfileMenuTile(
                      title: "Settings",
                      icon: Icons.settings,
                      onTap: () => myDialog(
                        context: context,
                        title: 'Upss Sorry',
                        content: 'This fitur not ready to use',
                        onPressed1: () => Navigator.pop(context),
                        onPressed2: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            myBotton(
                onPressed: () {
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
                label: "Logout",
                context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuTile(
      {String? title, IconData? icon, VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: Icon(
          icon!,
          color: Colors.black,
        ),
      ),
      title: Text(
        title!,
        style: kLabel,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
