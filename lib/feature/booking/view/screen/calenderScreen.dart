import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/core/widgets/calender.dart';
import 'package:tjhaz/core/widgets/fixed_bottom_button.dart';
import 'package:tjhaz/feature/booking/view/widgets/duration_container.dart';
import 'package:tjhaz/feature/booking/view/widgets/start_hour_container.dart';
import '../../../../core/styles/colors.dart';
import '../widgets/booking_headline.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FixedBottomButton(
        onPressed: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "check out".toUpperCase(),
              style: AppTypography.t16Bold.copyWith(color: AppColors.cWhite),
            ),
            Text(
              "Total: 100 ${AppLocalizationsString.kwdCurrency}",
              style: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingHeadline(title: "LA Capane"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffD9D9D9).withOpacity(0.2),
                  ),
                  child: AppCalender(
                    disabledFillColor: Color(0xffE0E0E0),
                    enabledFillColor: Color(0xffE0E0E0),
                  ),
                ),
                headline("DURATION"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        10,
                        (index) => InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            child: DurationContainer(
                                pricePerHour: 100.toString(),
                                isSelected: _currentIndex == index,
                                time: (index + 1).toString())),
                      )),
                ),
                headline("STARTING TIME"),
                Wrap(
                  spacing: 16.w,
                  runSpacing: 8.h,
                  alignment: WrapAlignment.start,
                  children: List.generate(
                      15,
                      (index) => StartingHourContainer(
                          time: index, isSelected: false, isAvailable: true)),
                ),
                verticalSpace(16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headline(String text) => Center(
    child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h),
          child: Text(
            text,
            style:
                AppTypography.t16Normal.copyWith(color: AppColors.primaryColor),
          ),
        ),
  );
}
