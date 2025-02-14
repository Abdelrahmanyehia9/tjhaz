import 'package:flutter/material.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0 , vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text("Recommended" ,style: AppTypography.t12Normal.copyWith(color: AppColors.secondaryColor , fontWeight: FontWeight.bold),),
          ) ,
          buildValidationRow('At least 1 lowercase letter', hasLowerCase),
          verticalSpace(2),
          buildValidationRow('At least 1 uppercase letter', hasUpperCase),
          verticalSpace(2),
          buildValidationRow(
              'At least 1 special character', hasSpecialCharacters),
          verticalSpace(2),
          buildValidationRow('At least 1 number', hasNumber),
          verticalSpace(2),
          buildValidationRow('At least 8 characters ', hasMinLength),
        ],
      ),
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
         CircleAvatar(
          radius: 2.5,
          backgroundColor: hasValidated ?Colors.green : AppColors.primaryColor
        ),
        horizontalSpace(6),
        Text(
          text,
          style: AppTypography.t12Normal.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? AppColors.primaryColor : AppColors.primaryColor,
          ),
        )
      ],
    );
  }
}
