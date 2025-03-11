import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_message.dart';
import 'package:tjhaz/feature/booking/logic/booking/add_new_booking_cubit.dart';
import 'package:tjhaz/feature/booking/logic/booking/add_new_booking_states.dart';
import 'package:tjhaz/feature/booking/view/widgets/booking_bottom_button.dart';
import 'package:tjhaz/feature/categories/view/widget/categories_containers.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:toastification/toastification.dart';

import '../../logic/booking/my_bookings_cubit.dart';
import '../widgets/reservation/headlines.dart';

class AddOnsScreen extends StatefulWidget {
  final EntertainmentDetailsModel model;

  const AddOnsScreen({super.key, required this.model});

  @override
  State<AddOnsScreen> createState() => _AddOnsScreenState();
}

class _AddOnsScreenState extends State<AddOnsScreen> {
  Set<int> selectedAddOns = {};

  @override
  Widget build(BuildContext context) {
    if (widget.model.addOns!.isEmpty) {
      return Scaffold(body: const Center(child: Text("NO ADDONS")));
    } else {
      return Scaffold(
      bottomNavigationBar: BlocListener<AddNewBookingCubit , AddNewBookingState>(
        listener: (context , state){
          if (state is AddNewBookingSuccess) {
            appToast(type: ToastificationType.success, tittle: AppStrings.bookingSuccess, description: state.message) ;
            context.go(AppRouter.bookingsScreen) ;

          }else if (state is AddNewBookingFailure) {
            appToast(type: ToastificationType.error, tittle: AppStrings.bookingFailed, description:state.message) ;
            context.go(AppRouter.homeScreen) ;

          }

        },
        child: BookingBottomButton(
          tittle: AppStrings.checkout.toUpperCase(),
          totalPrice: _calculateTotalPrice(),
          onPressed: () async{
            context.read<AddNewBookingCubit>().totalPrice = _calculateTotalPrice() ;
            context.read<AddNewBookingCubit>().addBook() ;
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              ReservationAppBarHeadline(title: widget.model.name),
              Center(
                child: Text(
                  AppStrings.addons.toUpperCase(),
                  style: AppTypography.t20Bold.copyWith(color: AppColors.secondaryColor),
                ),
              ),
              verticalSpace(16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: 168.w / 115.h,
                  ),
                  itemCount: widget.model.addOns!.length,
                  itemBuilder: (context, index) {
                    final addOn = widget.model.addOns![index];
                    final isSelected = selectedAddOns.contains(index);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedAddOns.remove(index);
                          } else {
                            selectedAddOns.add(index);
                          }
                        });
                      },
                      child: RectangularCategory(
                        name: addOn.title!,
                        spacing: 12,
                        img: addOn.img!,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        isActive: isSelected, // Highlight selected items
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    }
  }

  double _calculateTotalPrice() {
    return selectedAddOns.fold(context.read<AddNewBookingCubit>().totalPrice, (total, index) {
      return total + double.parse(widget.model.addOns![index].price!);
    });
  }
}
