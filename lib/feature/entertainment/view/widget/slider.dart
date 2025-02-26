import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/app_slider.dart';
import '../../../../core/widgets/box_action_button.dart';

class EntertainmentSlider extends StatelessWidget {
  final List<String> imageList ;
  const EntertainmentSlider({super.key , required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppSlider(height: screenHeight(context)*.3,imageList: imageList,),
        Positioned(
            bottom: 8.h,right: 8.w,
            child: BoxIconButton(icon: Icons.favorite))
      ],
    ) ;
  }
}
