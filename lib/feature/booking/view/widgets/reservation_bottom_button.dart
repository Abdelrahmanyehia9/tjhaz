import 'package:flutter/material.dart';
import 'package:tjhaz/core/helpers/spacing.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/fixed_bottom_button.dart';

class ReservationBottomButton extends StatelessWidget {
  final String tittle ;
  final double totalPrice ;
  final GestureTapCallback ? onPressed ;
  const ReservationBottomButton({super.key  ,required this.tittle ,required this.totalPrice  , this.onPressed  });

  @override
  Widget build(BuildContext context) {
    return  FixedBottomButton(
      onPressed: onPressed ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tittle.toUpperCase(),
            style: AppTypography.t16Bold,
          ),
          verticalSpace(4) ,
          Text(
            "${AppStrings.total}: ${totalPrice.toStringAsFixed(2)} ${AppStrings.kwdCurrency}",
            style: AppTypography.t12Normal,
          ),
        ],
      ),
    );
  }


}
