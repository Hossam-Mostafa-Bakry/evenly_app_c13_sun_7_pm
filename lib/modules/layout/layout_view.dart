import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

import 'home_tab.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(
            side: BorderSide(
          color: ColorPalette.white,
          width: 5,
        )),
        backgroundColor: ColorPalette.primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: ColorPalette.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorPalette.primaryColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorPalette.white,
        unselectedItemColor: ColorPalette.white,
        currentIndex: selectedIndex,
        onTap: _onBtnNavBarItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: "Maps",
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            activeIcon: Icon(Icons.favorite),
            label: "Likes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }

  _onBtnNavBarItemTapped(int index) {
    if (index == 2) return;
    selectedIndex = index;
    setState(() {});
  }
}
