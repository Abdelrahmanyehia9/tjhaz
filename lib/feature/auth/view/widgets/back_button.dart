import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/screen_size.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      GoRouter.of(context).pop() ;
    },
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor,
          fixedSize: Size(screenWidth(context) * .4, 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),)
      ),
      child: Icon(
        Icons.arrow_back, color: AppColors.cWhite, size: 30, weight: 6,),) ;


  }
}
