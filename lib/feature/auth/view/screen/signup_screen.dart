import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/app_validation.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_text_field.dart';
import 'package:tjhaz/feature/auth/logic/signup_cubit.dart';
import 'package:tjhaz/feature/auth/logic/signup_states.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_loading.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_toast.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/routes/app_router.dart';
import '../widgets/password_validations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
   TextEditingController usernameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController passwordConfirmController = TextEditingController();
   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>() ;

  @override
  void initState() {
    super.initState();

    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      if (mounted) {
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
    return Form(
      key: _globalKey ,
      child: Column(
        children: [
          AuthTextField(
              controller: usernameController,
              labelText: AppLocalizations.username,
              icon: Icons.person_outline,
              validator: AppValidators.validateUsername
          ),
          AuthTextField(
              controller:emailController,
              labelText: AppLocalizations.email,
              icon: Icons.email_outlined,
              validator: AppValidators.validateEmail),
          AuthTextField(
              controller: passwordController,
              labelText: AppLocalizations.password,
              icon: Icons.lock_outline,
              isPassword: true,
              validator: AppValidators.validatePassword
          ),
          PasswordValidations(
            hasLowerCase: hasLowercase,
            hasUpperCase: hasUppercase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
          AuthTextField(
            controller: passwordConfirmController,
            labelText: AppLocalizations.passwordConfirm,
            icon: Icons.lock_outline,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password shouldn't be empty";
              } else
              if (passwordController.text != passwordConfirmController.text) {
                return "Password Doesn't Match";
              }
            },
          ),
          verticalSpace(8),
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: 16.0.w,
            ),
            child: privacyPolicy(),
          ),
          BlocConsumer<SignupCubit, SignupStates>(
            builder: (context, state) {
              if (state is SignupStateLoading) {
                return AuthLoading();
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 8),
                  child: AuthButton(
                    tittle: AppLocalizations.signUp,
                    onPressed: () => validateThenSignup(context),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is SignupStateFailure) {
                toast(type: ToastificationType.error,
                    tittle: "Signup Failed",
                    description: state.errorMsg,
                    context: context);
              } else if (state is SignupStateSuccess) {
              GoRouter.of(context).push(AppRouter.homeLayout) ;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget privacyPolicy() =>
      Align(
        alignment:context.locale.languageCode == "ar" ? Alignment.centerRight : Alignment.centerLeft,
        child: Wrap(
          children: [
            Text(AppLocalizations.bySigningUp, style: AppTypography.t14Normal,),
            InkWell(
              child: Text(
                AppLocalizations.privacyPolicy,
                style: AppTypography.t14Bold,
              ),
            ),
            Text(AppLocalizations.terms , style: AppTypography.t14Normal,),
          ],
        ),
      );
  void validateThenSignup(BuildContext context) async {
    if (_globalKey.currentState!.validate()) {
      await context.read<SignupCubit>().signUpByEmailAndPassword(
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text) ;
    }
  }
  @override
  void dispose() {
    usernameController.dispose() ;
    emailController.dispose() ;
    passwordController.dispose() ;
    passwordConfirmController.dispose() ;
super.dispose();
  }
}
