import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/lottie_widget.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(width: screenWidth(context),height: screenHeight(context),
      color: Colors.black.withOpacity(0.4),
      child: LottieAnimation(

      ),
    ) ;;
  }
}
