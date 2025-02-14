import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/routes.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/text_field_outlined.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_header.dart';

import '../../../../core/helpers/app_regex.dart';
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
            TextFieldOutlined(
              controller: context.read<ResetPasswordCubit>().emailController,
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return "Email shouldn't be empty";
                  }else if (!AppRegex.isEmailValid(value)){
                    return "Please enter Valid Email" ;
                  }

                },
                labelText: "E-Mail",
                icon: Icons.email_outlined),
            AuthButton(
              tittle: "Send",
              onPressed: () {
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
