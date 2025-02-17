import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/app_validation.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/routes.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_text_field.dart';
import 'package:tjhaz/feature/auth/logic/signup_cubit.dart';
import 'package:tjhaz/feature/auth/logic/signup_states.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_loading.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_toast.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/helpers/app_regex.dart';
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
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;

  @override
  void initState() {
    super.initState();
    usernameController = context
        .read<SignupCubit>()
        .usernameController;
    emailController = context
        .read<SignupCubit>()
        .emailController;
    passwordController = context
        .read<SignupCubit>()
        .passwordController;
    passwordConfirmController = context
        .read<SignupCubit>()
        .passwordConfirmationController;
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
      key: context
          .read<SignupCubit>()
          .formKey,
      child: Column(
        children: [
          AuthTextField(
              controller: context
                  .read<SignupCubit>()
                  .usernameController,
              labelText: "Username",
              icon: Icons.person_outline,
              validator: AppValidators.validateUsername
          ),
          AuthTextField(
              controller: context
                  .read<SignupCubit>()
                  .emailController,
              labelText: "Email",
              icon: Icons.email_outlined,
              validator: AppValidators.validateEmail),
          AuthTextField(
              controller: passwordController,
              labelText: "Password",
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
            labelText: "Password Confirm",
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
                    tittle: "SIGN UP",
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
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Text("By signing up you agree to our ", textAlign: TextAlign.left , style: AppTypography.t14Normal,),
            InkWell(
              child: Text(
                "Privacy Policy ",
                style: AppTypography.t14Bold,
              ),
            ),
            Text("and Terms.", textAlign: TextAlign.left , style: AppTypography.t14Normal,),
          ],
        ),
      );

  void validateThenSignup(BuildContext context) async {
    if (context
        .read<SignupCubit>()
        .formKey
        .currentState!
        .validate()) {
      await context.read<SignupCubit>().signUpByEmailAndPassword(
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text) ;
    }
  }
  @override
  void dispose() {
passwordController.clear() ;
passwordConfirmController.clear() ;
super.dispose();
  }
}
