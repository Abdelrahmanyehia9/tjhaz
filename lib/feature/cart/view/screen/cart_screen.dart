import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/fixed_bottom_button.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';
import 'package:tjhaz/feature/cart/logic/cart_cubit.dart';
import 'package:tjhaz/feature/cart/logic/cart_states.dart';
import 'package:tjhaz/feature/cart/view/widgets/cart_item.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/errors_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> selectedItems = [];
  int totalItems = 0;

  void toggleSelectAll() {
    setState(() {
      selectedItems.length == totalItems
          ? selectedItems.clear()
          : selectedItems = List.generate(totalItems, (index) => index);
    });
  }

  @override
  void initState() {
    context.read<CartCubit>().getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      buildWhen: (previous, current) => current is CartStatesSuccess || current is CartStatesFailure,
      listener: (context, state) {
        if (state is CartStatesSuccess) {
          totalItems = context.read<CartCubit>().cartItems.length;
        }
      },
      builder: (context, state) {
        if (state is CartStatesSuccess) {
          List<CartModel> cartItems = context.read<CartCubit>().cartItems;
          totalItems = cartItems.length;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  children: [
                    AppHeadline(tittle: AppStrings.cart),
                    Expanded(
                      child: cartItems.isNotEmpty
                          ? Column(
                        children: [
                          InkWell(
                            onTap: toggleSelectAll,
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Text(
                                  selectedItems.length == totalItems ? AppStrings.unselectAll : AppStrings.selectAll,
                                  style: AppTypography.t12Bold.copyWith(color: AppColors.secondaryColor),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: totalItems,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedItems.contains(index)
                                        ? selectedItems.remove(index)
                                        : selectedItems.add(index);
                                  });
                                },
                                child: CartItem(isSelected: selectedItems.contains(index), cartModel: cartItems[index]),
                              ),
                            ),
                          ),
                        ],
                      )
                          : EmptyList(title: AppStrings.cart, icon: AppIcons.cart),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: FixedBottomButton(
              onPressed: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.checkout.toUpperCase(), style: AppTypography.t16Bold),
                  verticalSpace(4),
                  Text("${AppStrings.items}: ${selectedItems.length} / ${AppStrings.total}: ${calculateTotalPrice()} ${AppStrings.kwdCurrency}", style: AppTypography.t14Normal),
                ],
              ),
            ),
          );
        } else if (state is CartStatesFailure) {
          return Scaffold(body: AppErrorWidget(error: state.errorMsg));
        } else {
          return Scaffold(body: SizedBox());
        }
      },
    );
  }


  double calculateTotalPrice() {
    if (selectedItems.isEmpty || context.read<CartCubit>().cartItems.isEmpty) {
      return 0.0;
    }

    double totalPrice = 0.0;
    final cartItems = context.read<CartCubit>().cartItems;

    for (int index in selectedItems) {
      if (index < cartItems.length) {
        int currentItemQuantity = context.watch<CartCubit>().cartItems[index].itemQuantity ;
        totalPrice += cartItems[index].itemPrice * currentItemQuantity;
      }
    }
    return totalPrice;
  }
}