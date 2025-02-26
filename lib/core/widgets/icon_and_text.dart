import 'package:flutter/cupertino.dart';

import '../helpers/spacing.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';

class IconAndText extends StatelessWidget {
  final double? iconSize ;
  final  TextStyle?  textStyle ;
  final double? spacing ;
  final IconData icon  ;
  final String title ;
  const IconAndText({super.key , required this.icon , required this.title  , this.textStyle , this.iconSize , this.spacing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon , size: iconSize ?? 16,) ,
        horizontalSpace(spacing ?? 2) ,
        Text(title  , overflow: TextOverflow.ellipsis, style: textStyle ??  AppTypography.t10light.copyWith(color: AppColors.secondaryColor),)
      ],
    ) ;;
  }
}
