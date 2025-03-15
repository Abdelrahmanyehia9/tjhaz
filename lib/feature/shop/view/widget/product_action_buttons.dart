import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';
import 'package:tjhaz/feature/cart/logic/cart_modify_cubit.dart';
import 'package:tjhaz/feature/cart/logic/cart_modify_states.dart';
import 'package:tjhaz/feature/cart/view/widgets/product_quantiy.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';
import '../../data/model/product_mode.dart';

class ProductActionButtons extends StatefulWidget {
  final GestureTapCallback? addToCart;
  final ProductModel productModel;
  final GestureTapCallback? buyNow;

  const ProductActionButtons(
      {super.key, this.addToCart, this.buyNow, required this.productModel });

  @override
  State<ProductActionButtons> createState() => _ProductActionButtonsState();
}

class _ProductActionButtonsState extends State<ProductActionButtons> {
  late CartModel model  ;
  @override
  void initState() {
    model=  CartModel(
        addedDate: Timestamp.now(),
        itemName: widget.productModel.name,
        itemID: widget.productModel.id,
        itemImage: widget.productModel.images.first,
        itemPrice: widget.productModel.price,
        itemQuantity: 1) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h, bottom: 16.h),
      child: Column(
        children: [
          BlocBuilder<CartModifyCubit, CartModifyStates>(
              builder: (context, state) {
                int item = context.read<CartModifyCubit>().quantityMap[widget.productModel.id] ?? 0;
                print(item);

                return context
                    .read<CartModifyCubit>()
                    .quantityMap[widget.productModel.id] == 0
                    ? productActionButton(
                    title: AppStrings.addToCart,
                    context: context,
                    onPressed: () async {

                      context.loaderOverlay.show();
                      await context.read<CartModifyCubit>().addItemToCart(
                          cartModel: model) ;

                      setState(() {

                      });
                      if (context.mounted) context.loaderOverlay.hide();
                    })
                    : ProductQuantity(
                  cartModel: model, size: 26.sp,);
              }),
          // ProductQuantity(size: 24.sp,) ,
          verticalSpace(4),
          productActionButton(
              title: AppStrings.buyNow, context: context, onPressed: () {}),
        ],
      ),
    );
  }

  Widget productActionButton({GestureTapCallback? onPressed,
    required BuildContext context,
    required String title}) =>
      ElevatedButton(
        onPressed: onPressed, // Disable button if isDisabled is true
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor, // Change color if disabled
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          fixedSize: Size(screenWidth(context), 50.h),
        ),
        child: Text(
          title,
          style: AppTypography.t16Normal.copyWith(color: AppColors.cWhite),
        ),
      );
}
