import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class OnboardingContent extends StatelessWidget {
  final String image, title;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black38,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpace(48),
              Text(
                  "WELCOME",
                  style:  AppTypography.t20Bold.copyWith(color: AppColors.cWhite)
              ),
              verticalSpace(8),
              Text(
                  title.toUpperCase(),
                  style: AppTypography.t48Bold.copyWith(color: AppColors.cWhite , height: 0)
              ),
            ],
          ),
        ),
      ],
    );
  }
}