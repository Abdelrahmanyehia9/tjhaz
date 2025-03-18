import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_message.dart';
import 'package:tjhaz/feature/profile/logic/language_cubit.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import 'language_confirm_dialoge.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  @override
  void initState() {
    context.read<LanguageCubit>().getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, bool>(
      builder: (context, isArabic) => Center(
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ToggleButtons(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            isSelected: [!isArabic, isArabic],
            onPressed: (index) {
              // Check if selected index matches current language
              bool isCurrentlyEnglish = !isArabic;
              bool wantsEnglish = index == 0;

              // Only trigger dialog if language is actually changing
              if ((wantsEnglish && !isCurrentlyEnglish) ||
                  (!wantsEnglish && isCurrentlyEnglish)) {
                languageConfirmDialog(context: context, currentLngIndex: index);
              } else {
                appToast(
                    type: ToastificationType.warning,
                    style: ToastificationStyle.minimal,
                    tittle: AppStrings.warning,
                    description: AppStrings.youAlreadyUsingThisLanguage,
                    context: context);
              }
              // If it's the same language, do nothing
            },
            fillColor: AppColors.secondaryColor,
            selectedColor: Colors.white,
            color: AppColors.primaryColor,
            constraints: BoxConstraints(minWidth: 176.w, minHeight: 48.h),
            children: [
              Text(
                 'ENGLISH',
                style: AppTypography.t12Normal,
              ),
              Text(
                'عربي',
                style: AppTypography.t12Normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
