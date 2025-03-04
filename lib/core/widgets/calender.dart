import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/core/widgets/animation.dart';
import '../styles/colors.dart';

class AppCalender extends StatefulWidget {
  final Color? disabledFillColor;
  final Color? selectedFillColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? textStyle;
  final Map<String, List<int>>? reservedDays;
  final Color? selectedBorderColor;
  final Color? borderColor;
  final Color? reservedBorderColor;
  final Widget? customHeadLine;
  final Function(DateTime)? onDateSelected;
  final Function(List<DateTime>)? onLongPress;
  final bool? enableMultiSelect;
  final Color? enabledFillColor;
  final TextStyle? disabledTextStyle;
  final Function(String)? onChanged;
  final String? initialMonth;

  const AppCalender({
    super.key,
    this.disabledTextStyle,
    this.enabledFillColor,
    this.disabledFillColor,
    this.selectedFillColor,
    this.selectedTextStyle,
    this.textStyle,
    this.reservedDays,
    this.borderColor,
    this.selectedBorderColor,
    this.reservedBorderColor,
    this.customHeadLine,
    this.onDateSelected,
    this.onLongPress,
    this.enableMultiSelect,
    this.onChanged,
    this.initialMonth,
  });

  @override
  State<AppCalender> createState() => _AppCalenderState();
}

class _AppCalenderState extends State<AppCalender> {
  late DateTime _focusedDate;
  late DateTime _today;
  late DateTime _minDate;
  late DateTime _maxDate;
  final List<DateTime> _selectedDates = [];
  DateTime? _lastSelectedDate;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();

    int initialMonthIndex = _getMonthIndex(widget.initialMonth ?? DateFormat('MMM').format(_today).toLowerCase());
    _focusedDate = DateTime(_today.year, initialMonthIndex, 1 );

    _minDate = DateTime(_today.year, 1, 1);
    _maxDate = DateTime(_today.year, 12, 31);
  }

  int _getMonthIndex(String month) {
    Map<String, int> months = {
      "jan": 1, "feb": 2, "mar": 3, "apr": 4, "may": 5, "jun": 6,
      "jul": 7, "aug": 8, "sep": 9, "oct": 10, "nov": 11, "dec": 12
    };
    return months[month] ?? DateTime.now().month;
  }

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMM yyyy' ,AppConstants.currentLanguage).format(_focusedDate ).toUpperCase();
    int daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    int firstWeekday = DateTime(_focusedDate.year, _focusedDate.month, 1).weekday;
    int emptyCells = firstWeekday % 7;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpace(8),
        SlideFadeTransition(
          index: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, size: 20.sp, color: _focusedDate.isAfter(_minDate) ? AppColors.secondaryColor : Colors.grey),
                onPressed: _focusedDate.isAfter(_minDate)
                    ? () {
                  setState(() {
                    _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
                  });

                  if (widget.onChanged != null) {
                    String formattedMonth = DateFormat('MMM').format(_focusedDate).toLowerCase();
                    widget.onChanged!(formattedMonth);
                  }
                }
                    : null,
              ),
              Text(
                formattedMonth,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: (_focusedDate.year == _today.year && _focusedDate.month < 12)
                      ? AppColors.secondaryColor
                      : Colors.grey,
                  size: 20.sp,
                ),
                onPressed: (_focusedDate.year == _today.year && _focusedDate.month < 12)
                    ? () {
                  setState(() {
                    _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
                  });

                  if (widget.onChanged != null) {
                    String formattedMonth = DateFormat('MMM').format(_focusedDate).toLowerCase();
                    widget.onChanged!(formattedMonth);
                  }
                }
                    : null,
              ),
            ],
          ),
        ),
        _buildWeekDaysHeader(),
        verticalSpace(8),
        Flexible(child: _buildCalendarGrid(daysInMonth, emptyCells)),
        verticalSpace(8)
      ],
    );
  }

  Widget _buildWeekDaysHeader() {
    List<String> weekDays = [AppStrings.sun, AppStrings.mon, AppStrings.tue, AppStrings.wed, AppStrings.thu, AppStrings.fri, AppStrings.sat];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDays
          .map((day) => Expanded(
        child: SlideFadeTransition(
          index: 1,
          offsetY: -20,
          child: Center(
            child: Text(
              day,
              style: AppTypography.t11Normal.copyWith(color: AppColors.secondaryColor),
            ),
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid(int daysInMonth, int emptyCells) {
    String monthKey = DateFormat('MMM').format(_focusedDate).toLowerCase();
    List<int> bookedDays = widget.reservedDays?[monthKey] ?? [];
    List<Widget> dayWidgets = List.generate(emptyCells, (_) => Container());

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(_focusedDate.year, _focusedDate.month, day);
      bool isBooked = bookedDays.contains(day);
      bool isSelected = _selectedDates.contains(currentDate);
      bool isPast = currentDate.isBefore(_today.subtract(const Duration(days: 1)));

      dayWidgets.add(
        InkWell(
          onTap: (!isPast && !isBooked)
              ? () {
            setState(() {
              if (widget.enableMultiSelect ?? false) {
                if (_selectedDates.contains(currentDate)) {
                  _selectedDates.remove(currentDate);
                } else {
                  _selectedDates.add(currentDate);
                }
              } else {
                _selectedDates.clear();
                _selectedDates.add(currentDate);
              }
              _lastSelectedDate = currentDate;
            });
            if (widget.onDateSelected != null) {
              widget.onDateSelected!(currentDate);
            }
          }
              : null,
          child: SlideFadeTransition(
            index: day,
            offsetY: -40,
            duration: Duration(milliseconds: 100),
            child: Container(
              width: 20.w,
              height: 20.h,
              margin: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: isSelected ? widget.selectedFillColor ?? AppColors.secondaryColor : isPast || isBooked ? widget.disabledFillColor ?? Colors.grey.shade300 : widget.enabledFillColor ?? Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color:isPast || isBooked ? isSelected ? widget.selectedBorderColor ?? Colors.transparent : widget.reservedBorderColor ?? Colors.transparent : widget.borderColor ?? AppColors.secondaryColor, width: 1.w),
              ),
              alignment: Alignment.center,
              child: Text(
                "$day",
                style: AppTypography.t12Normal.copyWith(color: isSelected ? Colors.white: isBooked||isPast ? Colors.grey : AppColors.secondaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(crossAxisCount: 7,physics: NeverScrollableScrollPhysics(), shrinkWrap: true, children: dayWidgets ,);
  }
}
class CalenderIllustration extends StatelessWidget {
  const CalenderIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.0.h),
      child: Row(
        children: [
          illustrationItem(fillColor:const Color(0xffE0E0E0),text: AppStrings.unavailable , textColor:Colors.grey  ,  ) ,
          illustrationItem(fillColor:const Color(0xffE0E0E0),text: AppStrings.available , borderColor: AppColors.secondaryColor, textColor:AppColors.secondaryColor ,) ,
          illustrationItem(fillColor:AppColors.secondaryColor,text: AppStrings.selected , textColor:AppColors.secondaryColor ,) ,
        ],
      ),
    );
  }

  Widget illustrationItem({required Color fillColor , Color? borderColor ,required String text ,required Color textColor }) =>  Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
    child: Wrap(

      spacing: 4.w,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
              color: fillColor ,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: borderColor ?? Colors.transparent)
          ),
        ) ,
        Text(text , style: AppTypography.t12Normal.copyWith(color:textColor),)
      ],),
  ) ;



}
