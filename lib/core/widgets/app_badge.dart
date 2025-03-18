import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';

class AppBadge extends StatelessWidget {
  final Widget child;
  final int content ;
  const AppBadge({super.key ,  required this.child , required this.content});

  @override
  Widget build(BuildContext context) {
    return content != 0 ? badges.Badge(
        badgeAnimation: const badges.BadgeAnimation.slide(loopAnimation: false ,slideTransitionPositionTween: badges.SlideTween(begin: Offset(-0.6, 0.1) ,end: Offset(0, 0)), animationDuration: Duration(milliseconds: 200 , ), curve: Curves.linear),
        position: badges.BadgePosition.topEnd(top: 0 , end: 0),
        badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.secondaryColor , elevation: 0 , shape: badges.BadgeShape.circle , ),
        badgeContent: Text(content.toString(), style: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),),
        child : child
    ):child;}
}
