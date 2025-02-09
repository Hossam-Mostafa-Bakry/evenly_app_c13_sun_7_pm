import 'dart:async';

import 'package:evently_app_c13_sun_7_pm/core/constants/app_assets.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_route_name.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();

  const SplashView({super.key});
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          PagesRouteName.layout,
          (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AppAssets.eventlyAppLogo,
            height: mediaQuery.size.height * 0.25,
          ),
        ],
      ),
    );
  }
}
