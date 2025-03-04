import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation_bottom_button.dart';
import 'package:tjhaz/feature/categories/view/widget/categories_containers.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';

import '../widgets/reservation/headlines.dart';

class AddOnsScreen extends StatelessWidget {
  final EntertainmentDetailsModel model;

  const AddOnsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ReservationBottomButton(
        tittle: "Checkout ",
        totalPrice: model.price,
        onPressed: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              ReservationAppBarHeadline(title: model.name),
              Center(
                child: Text(
                  "ADD ONS",
                  style: AppTypography.t20Bold
                      .copyWith(color: AppColors.secondaryColor),
                ),
              ),
              verticalSpace(16) ,
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 168.w / 115.h),
                  children: List.generate(model.addOns!.length, (index) => RectangularCategory(
                    name: model.addOns![index].title!,
                    spacing: 12,
                    img: model.addOns![index].img!,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    isActive: true,
                  )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
