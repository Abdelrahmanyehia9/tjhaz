import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/widgets/text_field_outlined.dart';
import 'package:tjhaz/feature/auth/logic/signup_cubit.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
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
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController ;
  @override
  void initState() {
    super.initState();
    passwordController = context.read<SignupCubit>().passwordController ;
    passwordConfirmController = context.read<SignupCubit>().passwordConfirmationController ;
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
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          TextFieldOutlined(
            controller: context.read<SignupCubit>().usernameController,
            labelText: "Username",
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null||value.isEmpty) {
                return "Username shouldn't be empty";
              }
            },
          ),
          TextFieldOutlined(
              controller: context.read<SignupCubit>().emailController,
              labelText: "Email",
              icon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty ) {
                  return "Email shouldn't be empty";
                }else if (!AppRegex.isEmailValid(value)){
                  return "Please enter Valid Email" ;
                }

              } ),
          TextFieldOutlined(
              controller: passwordController,
            labelText: "Password",
            icon: Icons.lock_outline,
            isPassword: true,
      validator: (value) {
      if (value == null || value.isEmpty) {
      return "Password shouldn't be empty";
      }}
          ),
          PasswordValidations(
            hasLowerCase: hasLowercase,
            hasUpperCase: hasUppercase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
          TextFieldOutlined(
            controller: passwordConfirmController ,
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
          verticalSpace(8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: privacyPolicy(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8),
            child: AuthButton(
              tittle: "SIGN UP",
              onPressed: ()=>validateThenSignup(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget privacyPolicy() => Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Text("By signing up you agree to our ", textAlign: TextAlign.left),
            InkWell(
              child: Text(
                "Privacy Policy ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text("and Terms.", textAlign: TextAlign.left),
          ],
        ),
      );
  void validateThenSignup( BuildContext context){
    if(context.read<SignupCubit>().formKey.currentState!.validate()){

    }
  }
}
