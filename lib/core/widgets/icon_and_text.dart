import 'package:flutter/cupertino.dart';

import '../helpers/spacing.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';

class IconAndTextHorizontal extends StatelessWidget {
  final double? iconSize ;
  final  TextStyle?  textStyle ;
  final double? spacing ;
  final IconData icon  ;
  final String title ;
  final Color iconColor ;
  final Color textColor ;
  const IconAndTextHorizontal({super.key , required this.icon , required this.title  , this.textStyle , this.iconSize , this.spacing , this.iconColor = AppColors.primaryColor , this.textColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon , size: iconSize ?? 16,color: iconColor,) ,
        horizontalSpace(spacing ?? 2) ,
        Text(title  , overflow: TextOverflow.ellipsis, style: textStyle ??  AppTypography.t10light.copyWith(color: textColor),)
      ],
    ) ;;
  }
}
