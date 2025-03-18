import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';

import '../../../../core/helpers/spacing.dart';

class ProfileButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final GestureTapCallback ? onPressed;
  final bool filled  ;
  final bool visible ;
  final bool hasLeading  ;

  const ProfileButton({super.key, required this.text, required this.icon , this.onPressed , this.filled =false  , required this.visible , this.hasLeading =true});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) { return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0.h),
        child: InkWell(
          onTap: widget.onPressed,
          onTapDown: (_) => setState(() => isPressed = true),
          onTapUp: (_) => setState(() => isPressed = false),
          onTapCancel: () => setState(() => isPressed = false),
          child: Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: isPressed ||widget.filled ? AppColors.secondaryColor : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 0.5,
                    blurRadius: 0.4,
                    offset: const Offset(0, 2))
              ],
              border: Border.all(color: AppColors.secondaryColor), // Secondary color
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(widget.icon, size: 24.sp, color:isPressed || widget.filled? Colors.white : AppColors.secondaryColor),
                    horizontalSpace(4),
                    Text(
                      widget.text.toUpperCase(),
                      style: AppTypography.t12Normal.copyWith(color: isPressed || widget.filled? Colors.white : AppColors.primaryColor),
                    ),
                  ]),
                  widget.hasLeading ? Icon(Icons.arrow_forward_ios, size: 18, color: isPressed || widget.filled? Colors.white : AppColors.primaryColor) : const SizedBox(), // Secondary color
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
