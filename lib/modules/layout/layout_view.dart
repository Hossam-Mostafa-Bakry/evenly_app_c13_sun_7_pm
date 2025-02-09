import 'package:evently_app_c13_sun_7_pm/core/routes/pages_route_name.dart';
import 'package:evently_app_c13_sun_7_pm/modules/layout/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/theme/color_palette.dart';
import 'favorites/favorites_view.dart';
import 'home/home_view.dart';
import 'map/map_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const HomeView(),
    const MapView(),
    const FavoritesView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {

    var local = AppLocalizations.of(context)!;

    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            PagesRouteName.createNewEvent,
          );
        },
        child: const CircleAvatar(
          radius: 32,
          backgroundColor: ColorPalette.white,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: ColorPalette.primaryColor,
            child: Icon(
              Icons.add,
              size: 30,
              color: ColorPalette.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              selectedIndex == 0
                  ? "assets/icons/selcted_home_icn.png"
                  : "assets/icons/un_selcted_home_icn.png",
            )),
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              selectedIndex == 1
                  ? "assets/icons/selected_map_icn.png"
                  : "assets/icons/un_selected_map_icn.png",
            )),
            label: local.map,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              selectedIndex == 2
                  ? "assets/icons/selected_favorite_icn.png"
                  : "assets/icons/un_selected_favorite_icn.png",
            )),
            label: local.favorites,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              selectedIndex == 3
                  ? "assets/icons/selected_user_icn.png"
                  : "assets/icons/un_selected_user_icn.png",
            )),
            label: local.profile,
          ),
        ],
      ),
    );
  }
}
