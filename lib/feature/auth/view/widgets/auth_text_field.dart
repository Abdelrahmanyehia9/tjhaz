import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 6.0 , horizontal: 16),
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
              child: Icon(!hiddenPassword ?Icons.visibility_outlined  : Icons.visibility_off_outlined,color: AppColors.cDarkGrey,)) :null ,
          prefixIcon: Icon(widget.icon , color: AppColors.lightPrimaryColor,), // User icon
          labelText: widget.labelText,
          contentPadding: EdgeInsets.zero,
          labelStyle: AppTypography.t14Normal.copyWith(color: AppColors.lightPrimaryColor) ,
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
              color: AppColors.lightPrimaryColor ,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.primaryColor ,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red ,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red ,
              width: 1.0,
            ),
          ),

        ),
        validator: (value) {
          return widget.validator(value);
        },
      ),
    );
  }
}
