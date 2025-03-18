import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../../logic/language_cubit.dart';

void languageConfirmDialog({required BuildContext context, required int currentLngIndex}) =>
    showDialog(
      context: context,
      builder: (_) {
        final targetLang = currentLngIndex == 0 ? "en" : "ar"; // Target language

        // Define translations directly (replace with your actual translations)
        final Map<String, Map<String, String>> translations = {
          'en': {
            'languageChange': 'Change Language',
            'confirmMessage': 'Are you sure you want to change the language to english?',
            'cancel': 'Cancel',
            'confirm': 'Confirm'
          },
          'ar': {
            'languageChange': 'تغيير اللغة',
            'confirmMessage': 'هل أنت متأكد أنك تريد تغيير اللغة الى العربية؟',
            'cancel': 'إلغاء',
            'confirm': 'تأكيد'
          }
        };

        // Get the translations for the target language
        final targetTranslations = translations[targetLang]!;

        return AlertDialog(
          actionsAlignment: MainAxisAlignment.start,
          backgroundColor: AppColors.cWhite,
          title: Text(
            targetTranslations['languageChange']!,
            style: AppTypography.t14Bold.copyWith(color: AppColors.secondaryColor),
            textDirection: targetLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          ),
          content: Text(
            targetTranslations['confirmMessage']!,
            style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),
            textDirection: targetLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          ),
          actions: [
            CustomGestureDetector(
              child: ElevatedButton(
                onPressed: () async {
                  final newLang = targetLang;
                  await context.read<LanguageCubit>().toggleLanguage(newLang);
                   Restart.restartApp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: Text(
                  targetTranslations['confirm']!,
                  style: AppTypography.t12Normal,
                  textDirection: targetLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
            ),
            CustomGestureDetector(
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                style: TextButton.styleFrom(
                  overlayColor: Colors.transparent,
                ),
                child: Text(
                  targetTranslations['cancel']!,
                  style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),
                  textDirection: targetLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
            ),
          ],
        );
      },
    );