import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/text_field_outlined.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_header.dart';
import 'package:tjhaz/feature/auth/view/widgets/back_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/password_validations.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class SetupNewPassword extends StatefulWidget {
  const SetupNewPassword({super.key});

  @override
  State<SetupNewPassword> createState() => _SetupNewPasswordState();
}

class _SetupNewPasswordState extends State<SetupNewPassword> {
  bool isObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;


  @override
  void initState() {
    super.initState();
    passwordController = context.read<ResetPasswordCubit>().newPasswordController;
    passwordConfirmController = context.read<ResetPasswordCubit>().newPasswordConfirmController;

    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      if(mounted){
        setState(() {
          hasLowercase = AppRegex.hasLowerCase(passwordController.text);
          hasUppercase = AppRegex.hasUpperCase(passwordController.text);
          hasSpecialCharacters =
              AppRegex.hasSpecialCharacter(passwordController.text);
          hasNumber = AppRegex.hasNumber(passwordController.text);
          hasMinLength = AppRegex.hasMinLength(passwordController.text);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: context.read<ResetPasswordCubit>().newPasswordKey,
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
              TextFieldOutlined(
                controller: passwordController,
                labelText: "Password",
                icon: Icons.lock_outline,
                isPassword: true,
                validator: (value) {
                  return value == null||value.isEmpty
                      ?"Password shouldn't be empty" : null;
                },
              ),
              TextFieldOutlined(
                controller: passwordConfirmController,
                labelText: "Password Confirm",
                icon: Icons.lock_outline,
                isPassword: true,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Password shouldn't be empty" ;
                  }else if (passwordController.text != passwordConfirmController.text){
                    return "Password Doesn't Match" ;
                  }
                },
              ),
              PasswordValidations(
                  hasLowerCase: hasLowercase,
                  hasUpperCase: hasUppercase,
                  hasSpecialCharacters: hasSpecialCharacters,
                  hasNumber: hasNumber,
                  hasMinLength: hasMinLength),
              verticalSpace(
                8,
              ),
              AuthButton(
                tittle: "RESET",
                onPressed: () {
                 if(context.read<ResetPasswordCubit>().newPasswordKey.currentState!.validate()){

                 }
                },
              ),
              verticalSpace(
                screenHeight(context) * .05,
              ),
              AuthBackButton() ,
              verticalSpace(16)
            ],
          ),
        ),
      ),
    );
  }
}
