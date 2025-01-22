import 'package:evently_app_c13_sun_7_pm/core/constants/app_assets.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/center_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/dimensions_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_route_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/core/utils/firebase_services.dart';
import 'package:evently_app_c13_sun_7_pm/core/widgets/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/extensions/validations.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              AppAssets.eventlyAppLogo,
              height: 0.25.height,
            ),
            CustomTextField(
              controller: _emailController,
              hint: "Email",
              hintColor: ColorPalette.generalGreyColor,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "plz enter your email address";
                }
                if (!Validations.validateEmail(value)) {
                  return "plz enter your a valid email address";
                }
                return null;
              },
              prefixIcon: ImageIcon(
                AssetImage(
                  AppAssets.mailIcn,
                ),
                color: ColorPalette.generalGreyColor,
              ),
            ).setOnlyPadding(context, 0.03, 0.015, 0.0, 0.0),
            CustomTextField(
              controller: _passwordController,
              isPassword: true,
              maxLines: 1,
              hint: "Password",
              hintColor: ColorPalette.generalGreyColor,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "plz enter your email address";
                }
                return null;
              },
              prefixIcon: ImageIcon(
                AssetImage(
                  AppAssets.lockIcn,
                ),
                color: ColorPalette.generalGreyColor,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  navigatorKey.currentState!
                      .pushNamed(PagesRouteName.forgetPassword);
                },
                child: Text(
                  "Forget Password?",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: ColorPalette.primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: ColorPalette.primaryColor,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FirebaseServices.login(
                          emailAddress: _emailController.text,
                          password: _passwordController.text)
                      .then(
                    (value) {
                      EasyLoading.dismiss();
                      if (value) {
                        navigatorKey.currentState!.pushNamedAndRemoveUntil(
                          PagesRouteName.layout,
                          (route) => false,
                        );
                      }
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorPalette.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  )),
              child: Text(
                "Login",
                style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: ColorPalette.white),
              ).setVerticalPadding(context, 0.015),
            ).setVerticalPadding(context, 0.025),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Don’t Have Account ? ",
                    style: theme.textTheme.titleMedium,
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        navigatorKey.currentState!
                            .pushNamed(PagesRouteName.signUp);
                      },
                      child: Text(
                        "Create Account",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorPalette.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: ColorPalette.primaryColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                Text(
                  "OR",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: ColorPalette.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: ColorPalette.primaryColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
              ],
            ).setVerticalPadding(context, 0.02),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ColorPalette.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.googleIcn,
                    height: 0.03.height,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Login With Google",
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.primaryColor),
                  ).setVerticalPadding(context, 0.015),
                ],
              ),
            ).setVerticalPadding(context, 0.025),
          ],
        ).setCenter().setHorizontalPadding(context, 0.05),
      ),
    );
  }
}
