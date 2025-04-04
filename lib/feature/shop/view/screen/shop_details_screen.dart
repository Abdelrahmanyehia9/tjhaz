import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_slider.dart';
import 'package:tjhaz/feature/shop/view/widget/related_products.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../widget/product_action_buttons.dart';

class ShopDetailsScreen extends StatelessWidget {
  final ProductModel model;

  const ShopDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBackButton(),
                AppSlider(imageList: model.images ,id: model.id,),
                productTitle(),
                ProductActionButtons(
                  productModel: model,
                ),
                description(
                  model.description.localized,
                ),
                verticalSpace(16),
                RelatedProducts(productModel: model)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget productTitle() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.0.h, bottom: 8.h),
            child: Text(
              model.name[AppConstants.currentLanguage.toUpperCase()]!,

              style:
                  AppTypography.t20Bold.copyWith(color: AppColors.primaryColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                      style: AppTypography.t18Normal,
                      TextSpan(
                          text:
                              "${model.price.toStringAsFixed(3)} ${AppStrings.kwdCurrency}\t\t",
                          children: [
                            model.priceBeforeDiscount != null
                                ? TextSpan(
                                    text:
                                        "${model.priceBeforeDiscount!.toStringAsFixed(3)} ${AppStrings.kwdCurrency}",
                                    style: AppTypography.t14Normal.copyWith(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.grey))
                                : const TextSpan()
                          ])),
                ],
              ),

            ],
          ),
        ],
      );

  Widget description(String details) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.0.h, bottom: 8.h),
            child: Text(
              AppStrings.description.toUpperCase(),
              style:
                  AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),
            ),
          ),
          Text(
            details,
            style: AppTypography.t10Normal
                .copyWith(color: AppColors.lightPrimaryColor.withOpacity(0.7)),
          ),
        ],
      );
}
