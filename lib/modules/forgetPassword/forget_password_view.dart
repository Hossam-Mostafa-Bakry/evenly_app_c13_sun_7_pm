import 'package:evently_app_c13_sun_7_pm/core/constants/app_assets.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../core/theme/color_palette.dart';
import '../../core/widgets/custom_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AppAssets.forgetPasswordImg,
          ),
          const CustomTextField(
            hint: "Email",
            hintColor: ColorPalette.generalGreyColor,
            prefixIcon: ImageIcon(
              AssetImage(
                AppAssets.mailIcn,
              ),
              color: ColorPalette.generalGreyColor,
            ),
          ).setOnlyPadding(context, 0.015, 0.0, 0.0, 0.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ColorPalette.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                )),
            child: Text(
              "Reset Password",
              style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: ColorPalette.white),
            ).setVerticalPadding(context, 0.015),
          ).setVerticalPadding(context, 0.025),
        ],
      ).setHorizontalPadding(context, 0.05),
    );
  }
}
