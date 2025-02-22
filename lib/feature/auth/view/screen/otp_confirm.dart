import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/back_button.dart';

class OtpConfirmScreen extends StatefulWidget {
  const OtpConfirmScreen({super.key});

  @override
  State<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen> {
  late TextEditingController otp  ;
  @override
  void initState() {
otp = context.read<ResetPasswordCubit>().otpController ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeader(
                tittle: Text(
                  "VERIFY THE CODE",
                  style: AppTypography.t24Bold.copyWith(color: AppColors.cWhite),
                ),
                description:
                "We will send an email to verify your identity and complete the process.",
              ),
              otpPinCode() ,
              resendCode(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
                child: AuthButton(tittle: "Confirm" , onPressed: (){
                  GoRouter.of(context).push(AppRouter.setupNewPasswordScreen);
                }, isDisabled: otp.text.length !=4 ? true : false     ,),
              ),
              verticalSpace(screenHeight(context)*.175,) ,
              AuthBackButton(),
              verticalSpace(16)
            ],
          ),
        ));
  }

  Widget otpPinCode ()=>  Padding(
    padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
    child:                   SizedBox(
      width: screenWidth(context)*.85,
      child: PinCodeTextField(
        textStyle: AppTypography.t36Bold.copyWith(color: AppColors.primaryColor),
        appContext: context,
        length: 4,

        controller: context.read<ResetPasswordCubit>().otpController,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(

            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 70.h,
            fieldWidth: 70.w,
            selectedFillColor: Colors.transparent,
            inactiveFillColor: Colors.transparent,
            activeColor: AppColors.primaryColor,
            selectedColor: AppColors.primaryColor,
            inactiveColor: AppColors.cLightGrey
        ),
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        onChanged: (value) {

        },
      ),
    ),

  ) ;
  Widget resendCode() => Padding(
    padding:  EdgeInsets.only(bottom: 24.0.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive the code ? ",
          style: AppTypography.t14Normal.copyWith(color: AppColors.primaryColor),
        ),
        InkWell(
            child: Text(
              " Send again",
              style:
              TextStyle(color: AppColors.secondaryColor , fontWeight: FontWeight.bold),
            ))
      ],
    ),
  );

}
