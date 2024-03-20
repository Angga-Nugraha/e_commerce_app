import 'package:e_commerce_app/data/common/routes.dart';
import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/page/homePage/history_page.dart';
import 'package:e_commerce_app/presentation/page/homePage/home_screen_page.dart';
import 'package:e_commerce_app/presentation/page/homePage/notifications.dart';
import 'package:e_commerce_app/presentation/page/homePage/profile_page.dart';
import 'package:e_commerce_app/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationBarPage extends StatefulWidget {
  final int id;
  const NavigationBarPage({required this.id, super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const NotificationsPage(),
      HistoryPage(id: widget.id),
      const ProfilPage(),
    ];
  }

  List<SalomonBottomBarItem> _navBarsItems() {
    return [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: Text("Home", style: kLabel),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.notifications),
        title: Text("Notification", style: kLabel),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.article),
        title: Text("Order", style: kLabel),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person),
        title: Text("Profil", style: kLabel),
      ),
    ];
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: kLabel,
            ),
            content: Text(
              'Do you want to exit an App',
              style: kSubTitle,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: kSubTitle),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes', style: kSubTitle),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<UserBloc>(context, listen: false)
            ..add(FetchUserById(id: widget.id)),
          BlocProvider.of<CartBloc>(context, listen: false)
            ..add(GettingAllcart()),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
    canPop: false,
    onPopInvoked: (_) async{
      if (await _onWillPop()) {
        SystemNavigator.pop();
      }
    },
      // onWillPop: () => _onWillPop(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            leading: myIconButton(
              icon: Icons.menu_rounded,
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            trailing: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartHasdata) {
                  if (state.result.isNotEmpty) {
                    return Stack(
                      children: [
                        myIconButton(
                          icon: Icons.shopping_bag_outlined,
                          onPressed: () =>
                              Navigator.pushNamed(context, cartPageRoutes),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              Text(
                                state.result.length >= 10
                                    ? '...'
                                    : state.result.length.toString(),
                                style: kSubTitle.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }
                return myIconButton(
                  icon: Icons.shopping_bag_outlined,
                  onPressed: () => Navigator.pushNamed(context, cartPageRoutes),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                );
              },
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        drawer: DrawerWidget(),
        body: _buildScreens()[_currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          clipBehavior: Clip.antiAlias,
          child: SalomonBottomBar(
            backgroundColor: Colors.grey.shade300,
            curve: Curves.easeInOutSine,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.black,
            selectedColorOpacity: 0.1,
            items: _navBarsItems(),
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
          ),
        ),
      ),
    );
  }
}
