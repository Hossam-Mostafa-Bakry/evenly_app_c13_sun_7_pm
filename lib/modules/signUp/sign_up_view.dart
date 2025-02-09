import 'package:evently_app_c13_sun_7_pm/core/extensions/validations.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_route_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/firebase_auth_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/core/theme/color_palette.dart';
import '/core/constants/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/widgets/custom_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              AppAssets.eventlyAppLogo,
              height: 0.25.height,
            ),
            CustomTextField(
              controller: _nameController,
              hint: "Name",
              hintColor: ColorPalette.generalGreyColor,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "plz enter your name";
                }
                return null;
              },
              prefixIcon: ImageIcon(
                AssetImage(
                  AppAssets.personIcn,
                ),
                color: ColorPalette.generalGreyColor,
              ),
            ).setOnlyPadding(context, 0.03, 0.0, 0.0, 0.0),
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
            ).setOnlyPadding(context, 0.015, 0.0, 0.0, 0.0),
            CustomTextField(
              controller: _passwordController,
              isPassword: true,
              maxLines: 1,
              hint: "Password",
              hintColor: ColorPalette.generalGreyColor,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "plz enter your password";
                }
                if (!Validations.validatePassword(value)) {
                  return "plz enter your a valid password";
                }
                return null;
              },
              prefixIcon: ImageIcon(
                AssetImage(
                  AppAssets.lockIcn,
                ),
                color: ColorPalette.generalGreyColor,
              ),
            ).setOnlyPadding(context, 0.015, 0.0, 0.0, 0.0),
            CustomTextField(
              isPassword: true,
              maxLines: 1,
              hint: "Re-Password",
              hintColor: ColorPalette.generalGreyColor,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "plz enter your password";
                }
                if (value != _passwordController.text) {
                  return "re-password not match.";
                }
                return null;
              },
              prefixIcon: ImageIcon(
                AssetImage(
                  AppAssets.lockIcn,
                ),
                color: ColorPalette.generalGreyColor,
              ),
            ).setOnlyPadding(context, 0.015, 0.0, 0.0, 0.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FirebaseAuthService.createAccount(
                    emailAddress: _emailController.text,
                    password: _passwordController.text,
                  ).then(
                    (value) {
                      EasyLoading.dismiss();
                      if (value) {
                        navigatorKey.currentState!.pushNamedAndRemoveUntil(
                          PagesRouteName.signIn,
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
                ),
              ),
              child: Text(
                "Register",
                style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: ColorPalette.white),
              ).setVerticalPadding(context, 0.015),
            ).setVerticalPadding(context, 0.025),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Already Have Account ? ",
                    style: theme.textTheme.titleMedium,
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        navigatorKey.currentState!.pop();
                      },
                      child: Text(
                        "Login",
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
          ],
        ).setCenter().setHorizontalPadding(context, 0.05),
      ),
    );
  }
}
