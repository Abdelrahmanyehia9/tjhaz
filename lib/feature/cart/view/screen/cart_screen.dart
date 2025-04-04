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
    if (totalItems > 0) {
      setState(() {
        selectedItems = selectedItems.length == totalItems
            ? []
            : List.generate(totalItems, (index) => index);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      buildWhen: (previous, current) =>
      current is CartStatesSuccess || current is CartStatesFailure,
      listener: (context, state) {
        if (state is CartStatesSuccess || state is UpdateQuantitySuccess) {
          setState(() {
            totalItems = context.read<CartCubit>().cartItems.length;
            selectedItems = selectedItems
                .where((index) => index < totalItems)
                .toList();
          });
        }
      },
      builder: (context, state) {
        if (state is CartStatesSuccess) {
          List<CartModel> cartItems = context.read<CartCubit>().cartItems;

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
                                  selectedItems.length == totalItems
                                      ? AppStrings.unselectAll
                                      : AppStrings.selectAll,
                                  style: AppTypography.t12Bold.copyWith(
                                      color: AppColors.secondaryColor),
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
                                child: CartItem(
                                    isSelected:
                                    selectedItems.contains(index),
                                    cartModel: cartItems[index]),
                              ),
                            ),
                          ),
                        ],
                      )
                          : EmptyList(
                          title: AppStrings.cart, icon: AppIcons.cart),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: FixedBottomButton(
              onPressed: selectedItems.isEmpty ? null : () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.checkout.toUpperCase(),
                      style: AppTypography.t16Bold),
                  verticalSpace(4),
                  Text(
                    "${AppStrings.items}: ${selectedItems.length} / ${AppStrings.total}: ${calculateTotalPrice()} ${AppStrings.kwdCurrency}",
                    style: AppTypography.t14Normal,
                  ),
                ],
              ),
            ),
          );
        } else if (state is CartStatesFailure) {
          return Scaffold(body: AppErrorWidget(error: state.errorMsg));
        } else {
          return const Scaffold(body: SizedBox());
        }
      },
    );
  }

  double calculateTotalPrice() {
    final cartItems = context.read<CartCubit>().cartItems;

    return selectedItems
        .where((index) => index >= 0 && index < cartItems.length)
        .fold(
        0.0,
            (total, index) =>
        total + cartItems[index].itemPrice * cartItems[index].itemQuantity);
  }
}
