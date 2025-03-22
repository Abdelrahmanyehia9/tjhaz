import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/app_validation.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_text_field.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_header.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routes/app_router.dart';
import '../widgets/back_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            AuthHeader(
              tittle: Text(
                AppStrings.forgotPassword.toUpperCase(),
                style: AppTypography.t24Bold.copyWith(color: AppColors.cWhite),
              ),
              description:
                  AppStrings.weWillSendYouAnEmail,
            ),
            AuthTextField(
                validator: AppValidators.validateEmail ,
                labelText: AppStrings.email,
                icon: Icons.email_outlined),
            AuthButton(
              tittle: AppStrings.send,
              onPressed: () async{

              },
            ),
            verticalSpace(
              screenHeight(context) * .175,
            ),
            const AuthBackButton(),
            verticalSpace(16)
          ],
        ),
      ),
    ));
  }

}
