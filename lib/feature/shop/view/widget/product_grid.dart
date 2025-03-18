import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/styles/card_sizes.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/errors_widgets.dart';
import '../../../entertainment/view/widget/entertainment_loading.dart';
import '../../logic/products_cubit.dart';
import '../../logic/products_states.dart';

class ProductsGrid extends StatelessWidget {
  final ValueNotifier<String> vendorName;
  const ProductsGrid({super.key ,required this.vendorName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsStates>(
      builder: (context, state) {
        if (state is ProductsStatesSuccess) {
          return state.products.isNotEmpty
              ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: CardSizes.productCard.width / CardSizes.productCard.height,
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductCard(productModel: product);
            },
          )
              : EmptyList(title: vendorName.value);
        } else if (state is ProductsStatesFailure) {
          return AppErrorWidget(error: state.error);
        }
        return const GridLoading();
      },
    ) ;
  }
}
