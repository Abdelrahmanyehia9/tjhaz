import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/app_validation.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/routes.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_text_field.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_header.dart';
import '../../../../core/helpers/spacing.dart';
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
                "FORGET PASSWORD",
                style: AppTypography.t24Bold.copyWith(color: AppColors.cWhite),
              ),
              description:
                  " We will send you an email with instructions on how to recover it.",
            ),
            AuthTextField(
              controller: context.read<ResetPasswordCubit>().emailController,
                validator: AppValidators.validateEmail ,
                labelText: "E-Mail",
                icon: Icons.email_outlined),
            AuthButton(
              tittle: "Send",
              onPressed: () async{
                FirebaseAuth auth = FirebaseAuth.instance ;
               final  email = context.read<ResetPasswordCubit>().emailController.text.trim() ;
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
