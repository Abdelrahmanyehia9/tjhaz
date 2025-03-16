import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/feature/cart/logic/cart_cubit.dart';
import 'package:tjhaz/feature/cart/logic/cart_modify_cubit.dart';

import '../../../../core/styles/colors.dart';
import '../../data/model/cart_model.dart';
import '../../logic/cart_modify_states.dart';

class ProductQuantity extends StatefulWidget {
  final double? size;
  final CartModel cartModel;
  const ProductQuantity({super.key, this.size, required  this.cartModel , });

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  @override
  void initState() {
    context.read<CartModifyCubit>().getItemQuantity(itemID: widget.cartModel.itemID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartModifyCubit, CartModifyStates>(
      builder: (context, state) {
        final cubit = context.read<CartModifyCubit>();
        final quantity = cubit.quantityMap[widget.cartModel.itemID]??0;
        return  quantity == 0 ? InkWell(
          onTap:  ()  async{
            context.loaderOverlay.show()  ;
                await context.read<CartModifyCubit>().addItemToCart(cartModel: widget.cartModel)   ;
                setState(() {

                });
                if(context.mounted) context.loaderOverlay.hide();
          },
          child: Container(
            width:40.w,
            height: 25.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.secondaryColor,

            ) ,
              child: Icon(Icons.add , size: 20.sp , color: Colors.white,),
          ),
        ):   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColors.secondaryColor,
              ),
              child: InkWell(
                onTap: () async {
                  context.loaderOverlay.show();
                  await cubit.updateItemQuantity(true, widget.cartModel.itemID);
                  if (context.mounted) context.loaderOverlay.hide();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 4.w),
                  child: Icon(Icons.add, size: widget.size ?? 12, color: AppColors.cWhite),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.size != null ? widget.size! * .5 : 6.0.w),
              child: Text(quantity.toString(),
                  style: TextStyle(color: AppColors.primaryColor, fontSize: widget.size)),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: quantity !=  0 ? AppColors.secondaryColor : Colors.grey.shade400,
              ),
              child: InkWell(
                onTap: quantity != 0 ?   () async {

                  context.loaderOverlay.show();
                  await cubit.updateItemQuantity(false, widget.cartModel.itemID);
                  if (context.mounted) context.loaderOverlay.hide();



                } : null,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(Icons.remove, size: widget.size ?? 12, color: quantity != 0 ? Colors.white : Colors.grey.shade700),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
