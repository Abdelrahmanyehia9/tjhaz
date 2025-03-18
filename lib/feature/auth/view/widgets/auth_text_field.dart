import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/typography.dart';
import '../../../../core/styles/colors.dart';

class AuthTextField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController? controller;
  final bool? isPassword  ;
  final Function(String?) validator;

  const AuthTextField({

    super.key,
    this.isPassword ,
    required this.validator,
    required this.labelText,
    required this.icon,
    this.controller,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool hiddenPassword = true ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4.0.h , horizontal: 16.w),
      child: SizedBox(
        height: 46.h,
        child: TextFormField(


        style: AppTypography.t14light.copyWith(color: AppColors.primaryColor),
          controller: widget.controller,
          cursorColor: AppColors.primaryColor,
          obscureText: widget.isPassword == true ? hiddenPassword : false,
          decoration: InputDecoration(



            suffixIcon: widget.isPassword==true? InkWell(onTap: (){
              setState(() {
                hiddenPassword = !hiddenPassword ;
              });
            },
                child: Icon(!hiddenPassword ?Icons.visibility_outlined  : Icons.visibility_off_outlined,color: AppColors.lightPrimaryColor,size: 24.sp,)) :null ,
            prefixIcon: Icon(widget.icon  , size: 20.sp , weight: 100, color: AppColors.lightPrimaryColor,), // User icon
            labelText: widget.labelText,
            contentPadding: EdgeInsets.zero,
            labelStyle: AppTypography.t12Normal.copyWith(color: AppColors.lightPrimaryColor) ,
            focusColor: AppColors.primaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  color: AppColors.lightPrimaryColor // Border color
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: AppColors.lightPrimaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),

          ),
          validator: (value) {
            return widget.validator(value);
          },
        ),
      ),
    );
  }
}
