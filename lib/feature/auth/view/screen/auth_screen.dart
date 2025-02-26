import 'package:flutter/material.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/feature/auth/view/screen/login_screen.dart';
import 'package:tjhaz/feature/auth/view/screen/signup_screen.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_header.dart';

import '../../../../core/widgets/toggle_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(tittle: Image.asset(AppConstants.appLogo)) ,
             TogglePages(pages: [LoginScreen() , SignupScreen()] , title: [AppLocalizationsString.login , AppLocalizationsString.signUp],)
          ],
        ),
      ),
    );
  }
}
