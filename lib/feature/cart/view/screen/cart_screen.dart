import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/fixed_bottom_button.dart';
import 'package:tjhaz/feature/cart/view/widgets/cart_item.dart';

import '../../../../core/widgets/global_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> selectedIndex = [];
  final int totalItems = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FixedBottomButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Checkout",
              style: AppTypography.t16Bold,
            ),
            verticalSpace(4),
            Text(
              "${selectedIndex.length} Item | Total : 200.00 KWD".toUpperCase(),
              style: AppTypography.t14Bold,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              GlobalAppBar(),
              AppHeadline(
                tittle: "Cart",
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: AppTypography.t14Bold,
                      foregroundColor: AppColors.secondaryColor , overlayColor: Colors.transparent),
                  onPressed: () {
                    setState(() {
                      if (selectedIndex.length == totalItems) {
                        selectedIndex.clear(); // Unselect all
                      } else {
                        selectedIndex = List.generate(totalItems, (index) => index); // Select all
                      }
                    });
                  },
                  child: Text(
                    selectedIndex.length == totalItems ? "Unselect All".toUpperCase() : "Select All".toUpperCase(),
                    ),
                  ),
                ),

              Expanded(
                child: ListView.builder(
                  itemCount: totalItems,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        if (selectedIndex.contains(index)) {
                          selectedIndex.remove(index);
                        } else {
                          selectedIndex.add(index);
                        }
                      });
                    },
                    child: CartItem(isSelected: selectedIndex.contains(index)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
