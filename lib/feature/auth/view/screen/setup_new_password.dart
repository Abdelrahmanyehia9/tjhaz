import 'package:flutter/material.dart';
import 'package:tjhaz/core/helpers/app_validation.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_text_field.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_header.dart';
import 'package:tjhaz/feature/auth/view/widgets/back_button.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class SetupNewPassword extends StatefulWidget {
  const SetupNewPassword({super.key});

  @override
  State<SetupNewPassword> createState() => _SetupNewPasswordState();
}

class _SetupNewPasswordState extends State<SetupNewPassword> {



  @override
  void initState() {
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              AuthHeader(
                tittle: Text(
                  "RESET PASSWORD",
                  style: AppTypography.t24Bold.copyWith(color: AppColors.cWhite),
                ),
                description:
                    "You must choose a strong password that will protect your information.",
              ),
              const AuthTextField(
                labelText: "Password",
                icon: Icons.lock_outline,
                isPassword: true,
                validator: AppValidators.validatePassword
              ),
              AuthTextField(
                labelText: "Password Confirm",
                icon: Icons.lock_outline,
                isPassword: true,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Password shouldn't be empty" ;
                  }else if (true){
                    return "Password Doesn't Match" ;
                  }
                },
              ),
              verticalSpace(
                8,
              ),
              AuthButton(
                tittle: "RESET",
                onPressed: () {

                },
              ),
              verticalSpace(
                screenHeight(context) * .05,
              ),
              const AuthBackButton() ,
              verticalSpace(16)
            ],
          ),
        ),
      ),
    );
  }
}
