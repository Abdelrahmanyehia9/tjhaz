import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/core/widgets/app_message.dart';
import 'package:tjhaz/feature/cart/logic/cart_cubit.dart';
import 'package:tjhaz/feature/cart/logic/cart_states.dart';

import '../../../../core/database/local/shared_prefrences_constants.dart';
import '../../../../core/database/local/shared_prefrences_helper.dart';
import '../../../../core/styles/colors.dart';
import '../../data/model/cart_model.dart';

class ProductQuantity extends StatefulWidget {
  final double? size;
  final CartModel cartModel;
  const ProductQuantity({super.key, this.size, required this.cartModel});

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(

      builder: (context, state) {



        final cubit = context.read<CartCubit>();

        // Check if the item exists in the cart, and get its quantity safely
        final cartItem = cubit.cartItems.where((element) => element.itemID == widget.cartModel.itemID).toList();
        final int quantity = cartItem.isNotEmpty ? cartItem.first.itemQuantity : 0;
        final bool isLoading = state is UpdateQuantityLoading && state.itemLoading == widget.cartModel.itemID;


        return quantity == 0 ? InkWell(
          onTap: SharedPrefHelper.getBool(SharedPrefConstants.isAnonymous) ?? true ? () {
            anonymousBottomSheet(context: context);
          } : () async {
            await cubit.addItemToCart(model: widget.cartModel);
            setState(() {});
          },
          child: Container(
            width: 40.w,
            height: 25.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.secondaryColor,
            ),
            child: isLoading ? SizedBox(
              width: 20.w,height: 20.w,
                child: const CircularProgressIndicator(color: Colors.white,strokeWidth: 1.8,)) :  Icon(Icons.add, size: 20.sp, color: Colors.white),
          ),
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColors.secondaryColor,
              ),
              child: InkWell(
                onTap: () async {
                  await cubit.updateItemQuantity(true, widget.cartModel.itemID);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 4.w),
                  child:  Icon(Icons.add, size: widget.size ?? 12, color: AppColors.cWhite),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.size != null ? widget.size! * .5 : 6.0.w),
              child: isLoading ? SizedBox(
                width: widget.size ?? 20.w,height: widget.size ?? 20.h,
                  child: CircularProgressIndicator(color: AppColors.secondaryColor,strokeWidth: 1,)) : Text(
                  quantity.toString(),
                  style: TextStyle(color: AppColors.primaryColor, fontSize: widget.size)
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: quantity != 0 ? AppColors.secondaryColor : Colors.grey.shade400,
              ),
              child: InkWell(
                onTap: quantity != 0 ? () async {
                  if (quantity == 1) {
                    await cubit.removeItemFromCart(itemID: widget.cartModel.itemID);
                  } else {
                    await cubit.updateItemQuantity(false, widget.cartModel.itemID);
                  }
                } : null,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                      Icons.remove,
                      size: widget.size ?? 12,
                      color: quantity != 0 ? Colors.white : Colors.grey.shade700
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}