import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/helpers/app_validation.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/feature/auth/logic/login_cubit.dart';
import 'package:tjhaz/feature/auth/logic/login_states.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_loading.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/routes/app_router.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController() ;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return  LoaderOverlay(
      child: Form(
        key: _globalKey,
        child: Column(
          children: [
          AuthTextField(
            controller: emailController,
            labelText: AppLocalizationsString.email,
            icon: Icons.email_outlined,
            validator: AppValidators.validateEmail
          ),
          AuthTextField(
            controller: passwordController,
          labelText: AppLocalizationsString.password,
            isPassword: true,
            icon: Icons.lock_outline,
            validator: AppValidators.validatePassword
          ),
          verticalSpace(8) ,
          forgetPassword(context),
          verticalSpace(30) ,
          BlocListener<LoginCubit , LoginStates>(
           child:  AuthButton(tittle : AppLocalizationsString.login , onPressed: ()=>validateThenLogin(context)  ) ,

              listener: (context , state){
                if(state is LoginStateFailure){
                  toast(context: context , type: ToastificationType.error , tittle: "Login Failure"  , description: state.errorMsg ) ;
                }else if (state is LoginStateSuccess){
                  GoRouter.of(context).push(AppRouter.homeLayout) ;
                }
              },
          ),
          AuthButton(tittle:AppLocalizationsString.continueAsGuest, onPressed: (){},) ,

        ],),
      ),
    );
  }

  Widget forgetPassword(context) => Padding(
    padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
    child: Row(
          children: [
            Text(
            AppLocalizationsString.forgotPassword,style: AppTypography.t14Normal.copyWith(color: AppColors.primaryColor ),
            ),
            InkWell(
              onTap: (){
                GoRouter.of(context).push(AppRouter.forgetPasswordPage) ;
              },
                child: Text(
              AppLocalizationsString.resetNow.tr(),
              style:AppTypography.t14Normal.copyWith(color: AppColors.secondaryColor)
            ))
          ],
        ),
  );
  void validateThenLogin( BuildContext context)async{
  String email = emailController.text.trim()  ;
  String password = passwordController.text ;
  if(_globalKey.currentState!.validate()){
    context.loaderOverlay.show() ;
    await context.read<LoginCubit>().login(email: email,password:  password) ;
    if(context.mounted){
      context.loaderOverlay.hide() ;
    }
  }
}

@override
  void dispose() {
emailController.dispose()  ;
passwordController.dispose() ;
super.dispose();
  }
}


