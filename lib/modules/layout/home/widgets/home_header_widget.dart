import 'package:flutter/material.dart';

import '../../../../core/theme/color_palette.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Container(
      height: mediaQuery.size.height * 0.25,
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: ColorPalette.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back ✨",
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: ColorPalette.white),
                  ),
                  Text(
                    "John Safwat",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/un_selected_map_icn.png",
                        height: 25,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Cairo, Egypt",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    size: 28,
                    color: ColorPalette.white,
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "EN",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
