import 'package:flutter/cupertino.dart';

import '../helpers/spacing.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';

class IconAndText extends StatelessWidget {
  final IconData icon  ;
  final String title ;
  const IconAndText({super.key , required this.icon , required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon , size: 16,) ,
        horizontalSpace(2) ,
        Text(title  , overflow: TextOverflow.ellipsis, style: AppTypography.t10light.copyWith(color: AppColors.secondaryColor),)
      ],
    ) ;;
  }
}
