import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/utils/routes.dart';
import 'package:tjhaz/feature/auth/logic/login_cubit.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/widgets/text_field_outlined.dart';
import '../widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
        TextFieldOutlined(
          controller: context.read<LoginCubit>().emailController,
          labelText: 'Email',
          icon: Icons.email_outlined,
          validator: (value) {
            if (value == null || value.isEmpty ) {
              return "Email shouldn't be empty";
            }else if (!AppRegex.isEmailValid(value)){
              return "Please enter Valid Email" ;
            }

          }
        ),
        TextFieldOutlined(
          controller: context.read<LoginCubit>().passwordController,
          labelText: 'Password',
          isPassword: true,
          icon: Icons.lock_outline,
          validator: (value){
            return value == null || value.isEmpty ?  "Password shouldn't be empty" : null ;
          },
        ),
        verticalSpace(8,) ,
        forgetPassword(context),
        verticalSpace( 30,) ,
        AuthButton(tittle : "LOG IN"  , onPressed: ()=>validateThenLogin(context)  ) ,
        AuthButton(tittle : "Continue as Guest" , onPressed: (){},) ,

      ],),
    );
  }

  Widget forgetPassword(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
          children: [
            Text(
              "Haven't remember your password ? ",
            ),
            InkWell(
              onTap: (){
                GoRouter.of(context).push(AppRouter.forgetPasswordPage) ;
              },
                child: Text(
              "Reset now",
              style:
                  TextStyle(color: AppColors.secondaryColor , fontWeight: FontWeight.bold),
            ))
          ],
        ),
  );
void validateThenLogin( BuildContext context){
  if(context.read<LoginCubit>().formKey.currentState!.validate()){

  }
}
}


