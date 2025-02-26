import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/app_validation.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_text_field.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
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
        key: context.read<ResetPasswordCubit>().resetPasswordKey,
        child: Column(
          children: [
            AuthHeader(
              tittle: Text(
                AppLocalizationsString.forgotPassword.toUpperCase(),
                style: AppTypography.t24Bold.copyWith(color: AppColors.cWhite),
              ),
              description:
                  AppLocalizationsString.weWillSendYouAnEmail,
            ),
            AuthTextField(
              controller: context.read<ResetPasswordCubit>().emailController,
                validator: AppValidators.validateEmail ,
                labelText: AppLocalizationsString.email,
                icon: Icons.email_outlined),
            AuthButton(
              tittle: AppLocalizationsString.send,
              onPressed: () async{

                if(context.read<ResetPasswordCubit>().resetPasswordKey.currentState!.validate()){
                  GoRouter.of(context).push(AppRouter.confirmOtpScreen);
                }
              },
            ),
            verticalSpace(
              screenHeight(context) * .175,
            ),
            AuthBackButton(),
            verticalSpace(16)
          ],
        ),
      ),
    ));
  }

}
