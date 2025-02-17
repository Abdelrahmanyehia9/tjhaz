import 'package:flutter/material.dart';
import 'package:tjhaz/core/styles/typography.dart';
import '../styles/colors.dart';

class TextFieldOutlined extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController? controller;
  final bool? isPassword  ;
  final Function(String?) validator;

  const TextFieldOutlined({

    super.key,
    this.isPassword ,
    required this.validator,
    required this.labelText,
    required this.icon,
    this.controller,
  });

  @override
  State<TextFieldOutlined> createState() => _TextFieldOutlinedState();
}

class _TextFieldOutlinedState extends State<TextFieldOutlined> {
  bool hiddenPassword = true ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0 , horizontal: 16),
      child: TextFormField(

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
          prefixIcon: Icon(widget.icon , color: AppColors.primaryColor,), // User icon
          labelText: widget.labelText,
          labelStyle: AppTypography.t16Normal.copyWith(color: AppColors.primaryColor) ,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
                color: AppColors.primaryColor // Border color
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.primaryColor ,
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
