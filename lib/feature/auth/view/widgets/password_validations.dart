import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import '../../../../core/helpers/spacing.dart';


class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.0.w , vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom: 2.0.h),
            child: Text(AppStrings.recommended ,style: AppTypography.t12Normal.copyWith(color: AppColors.secondaryColor , fontWeight: FontWeight.bold),),
          ) ,
          buildValidationRow(AppStrings.atLeast1Lowercase, hasLowerCase),
          verticalSpace(2),
          buildValidationRow(AppStrings.atLeast1Uppercase, hasUpperCase),
          verticalSpace(2),
          buildValidationRow(
              AppStrings.atLeast1SpecialCharacter, hasSpecialCharacters),
          verticalSpace(2),
          buildValidationRow(AppStrings.atLeast1Number, hasNumber),
          verticalSpace(2),
          buildValidationRow(AppStrings.atLeast8Characters, hasMinLength),
        ],
      ),
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
         CircleAvatar(
          radius: 2.5,
          backgroundColor: hasValidated ?Colors.green : AppColors.lightPrimaryColor
        ),
        horizontalSpace(6),
        Text(
          text,
          style: AppTypography.t12Normal.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? AppColors.lightPrimaryColor : AppColors.lightPrimaryColor,
          ),
        )
      ],
    );
  }
}
