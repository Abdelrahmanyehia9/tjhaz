import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/feature/shop/data/model/product_mode.dart';
import 'package:tjhaz/feature/shop/logic/related_products_cubit.dart';
import 'package:tjhaz/feature/shop/logic/related_products_states.dart';
import 'package:tjhaz/feature/shop/view/widget/related_product_loading.dart';
import '../../../../core/styles/card_sizes.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/cached_image_widget.dart';

class RelatedProducts extends StatefulWidget {
  final ProductModel productModel;

  const RelatedProducts({super.key, required this.productModel});

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RelatedProductsCubit>().getRelatedProducts(widget.productModel);
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelatedProductsCubit, RelatedProductsStates>(
      builder: (context, state) {
        if (state is RelatedProductsStatesSuccess &&
            state.products.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizationsString.youMightLikeThis,
                style: AppTypography.t18Bold.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: CardSizes.squareCard.height + 16,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          item(state.products[index].images.first)),
                ),
              ),
            ],
          );
        } else if (state is RelatedProductsStatesLoading) {
          return RelatedProductsLoading();
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget item(String imgUrl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
              width: CardSizes.squareCard.width,
              height: CardSizes.squareCard.height,
              child: CachedImageWidget(imgUrl: imgUrl)),
        ),
      );
}

