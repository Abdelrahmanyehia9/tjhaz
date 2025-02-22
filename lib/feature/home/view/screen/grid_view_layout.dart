import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/widgets/cards/product_card.dart';
import 'package:tjhaz/feature/home/view/widgets/home_app_bar.dart';
import '../../../../core/styles/card_sizes.dart';
import '../../../../core/widgets/cards/square_card.dart';

class GridViewLayout extends StatelessWidget {
  const GridViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              HomeAppBar(),
              gridHeadline("Activities"),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          CardSizes.productCard.width/ CardSizes.productCard.height,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h),
                  children: [
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gridHeadline(String tittle) => Padding(
        padding: EdgeInsets.only(top: 16.0.h, bottom: 24.h),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.secondaryColor,
                    size: 24.sp,
                  ),
                  Text(
                    "BACK",
                    style: AppTypography.t12Bold
                        .copyWith(color: AppColors.primaryColor),
                  )
                ],
              ),
            ),
            Spacer(),
            Text(
              tittle.toUpperCase(),
              style: AppTypography.t24Bold
                  .copyWith(color: AppColors.secondaryColor),
            ),
            Spacer()
          ],
        ),
      );
}

