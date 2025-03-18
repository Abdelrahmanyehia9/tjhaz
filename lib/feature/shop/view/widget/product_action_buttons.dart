import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/core/widgets/app_message.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';
import 'package:tjhaz/feature/cart/logic/cart_cubit.dart';
import 'package:tjhaz/feature/cart/logic/cart_states.dart';
import 'package:tjhaz/feature/cart/view/widgets/product_quantiy.dart';
import '../../../../core/database/local/shared_prefrences_constants.dart';
import '../../../../core/database/local/shared_prefrences_helper.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';
import '../../data/model/product_mode.dart';

class ProductActionButtons extends StatefulWidget {
  final GestureTapCallback? addToCart;
  final ProductModel productModel;
  final GestureTapCallback? buyNow;

  const ProductActionButtons(
      {super.key, this.addToCart, this.buyNow, required this.productModel});

  @override
  State<ProductActionButtons> createState() => _ProductActionButtonsState();
}

class _ProductActionButtonsState extends State<ProductActionButtons> {
  late CartModel model;

  @override
  void initState() {
    model = CartModel(
        addedDate: Timestamp.now(),
        itemName: widget.productModel.name,
        itemID: widget.productModel.id,
        itemImage: widget.productModel.images.first,
        itemPrice: widget.productModel.price,
        itemQuantity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h, bottom: 16.h),
      child: Column(
        children: [
          BlocBuilder<CartCubit, CartStates>(
              builder: (context, state) {
                final cartCubit = context.read<CartCubit>();

                final isItemInCart = cartCubit.cartItems
                    .any((element) => element.itemID == model.itemID);
               final bool isLoading = state is UpdateQuantityLoading && state.itemLoading == model.itemID;
                return !isItemInCart
                    ? isLoading? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                                        width: 20.w,height: 20.w,
                      child: const CircularProgressIndicator(color: AppColors.secondaryColor, strokeWidth: 1.8,)),
                    ) : productActionButton(title: AppStrings.addToCart, context: context, onPressed: SharedPrefHelper.getBool(SharedPrefConstants.isAnonymous) ?? true ? () {
                      anonymousBottomSheet(context: context);
                    }
                        : () async {
                      // Add the item to cart instead of updating quantity
                      await cartCubit.addItemToCart(model: model);
                      setState(() {});
                    })
                    : ProductQuantity(
                  cartModel: model,
                  size: 26.sp,
                );
              }),
          verticalSpace(4),
          productActionButton(
              title: AppStrings.buyNow, context: context, onPressed: () {}),
        ],
      ),
    );
  }

  Widget productActionButton({
    GestureTapCallback? onPressed,
    required BuildContext context,
    required String title
  }) => CustomGestureDetector(
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        fixedSize: Size(screenWidth(context), 50.h),
      ),
      child: Text(
        title,
        style: AppTypography.t16Normal.copyWith(color: AppColors.cWhite),
      ),
    ),
  );
}